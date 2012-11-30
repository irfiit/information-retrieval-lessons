module InformationRetrievalLessons
	module Crawlers
		## 
		# 
		# Simple web crawler.
		#
		class Crawler
			DEFAULT_OPTIONS = {
				max_depth: nil, 
				download_limit: nil, 
				url_pattern: nil, 
				filter: nil
			}

			##
			#
			# Create a new Crawler.
			#
			# @param repository Repository from InformationRetrievalLessons::Repositories to process downloaded documents.
			# @param queue Either InformationRetrievalLessons::Crawlers::BreadthFirstQueue or InformationRetrievalLessons::Crawlers::DepthFirstQueue.
			# @param options Set max_depth (Integer), download_limit (Integer), url_pattern (RegExp) or filter (Lambda).
			#
			# Examples:
			#
			# Limit number of downloaded documents.
			# 	InformationRetrievalLessons::Crawlers::Crawler.new(repository, queue, download_limit: 100)
			#
			# Restrict crawler to single domain.
			# 	InformationRetrievalLessons::Crawlers::Crawler.new(repository, queue, url_pattern: %r{\Ahttp://www\.fiit\.stuba\.sk})
			#
			# Filter out all documents larger than 10 KB.
			# 	InformationRetrievalLessons::Crawlers::Crawler.new(repository, queue, filter: lambda { |document| document.size > 10000 })
			# 
			# Download only PDF documents.
			# 	InformationRetrievalLessons::Crawlers::Crawler.new(repository, queue, filter: lambda { |document| document.content_type != 'application/pdf' })
			#
			def initialize(repository, queue, options = {})
				@repository = repository
				@queue = queue
				@options = DEFAULT_OPTIONS
				@options.merge!(options)
				@visited_urls = {}
			end

			##
			#
			# Starts crawler.
			#
			# @param [String] url Starting URL.
			#
			def crawl(url)
				# initial link
				@queue.add_link(Link.new(url))

				downloaded = 0
				last_host = ''

				while not @queue.empty?
					link = @queue.remove_link

					# max depth?
					next if @options[:max_depth] and link.depth > @options[:max_depth]

					# visited?
					if @visited_urls[link.url]
						
						# add another anchor text
						if @repository.respond_to? :add_anchor_text
							@repository.add_anchor_text link.url, link.anchor_text
						end

						next
					else
						@visited_urls[link.url] = true
					end

					# be polite
					sleep(0.2) if last_host == link.uri.host
					last_host = link.uri.host

					begin
						# download
						#puts link.url
						response = Faraday.get(link.url)

						# document factory
						document = Documents::Document.from_url_and_response(link.url, response)
						
						if document
							downloaded += 1

							# add links to queue unless they are filtered
							if document.respond_to? :urls
								document.urls.each do |l, t|
									if not @options[:url_pattern] or @options[:url_pattern] =~ l
										@queue.add_link Link.new(l, t, link.url, link.depth + 1)
									end
								end
							end

							# add first anchor text
							document.anchor_text = link.anchor_text

							# add document to repository unless it is filtered
							unless @options[:filter] and @options[:filter].call(document)
								@repository.process_document(document)
							end
						end
					rescue Faraday::Error, URI::Error => e
						puts "#{link.url}: #{e}"
					end

					# download limit reached?
					break if @options[:download_limit] and downloaded >= @options[:download_limit]
				end
			end
		end
	end
end