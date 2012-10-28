require 'faraday'

module Crawlers
	class Crawler
		DEFAULT_OPTIONS = {
			max_depth: nil, 
			download_limit: nil, 
			url_pattern: nil, 
			filter: nil
		}

		def initialize(repository, queue, options = {})
			@repository = repository
			@queue = queue
			@options = DEFAULT_OPTIONS
			@options.merge!(options)
			@visited_urls = {}
		end

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
				next if @visited_urls[link.url]
				@visited_urls[link.url] = true

				# be polite
				sleep(0.2) if last_host == link.uri.host
				last_host = link.uri.host

				begin
					# download
					response = Faraday.get(link.url)

					document = ::Documents::Document.from_url_and_response(link.url, response)
					if document
						downloaded += 1

						# add links to queue unless they are filtered
						if document.respond_to? :urls
							document.urls.each do |l|
								if not @options[:url_pattern] or @options[:url_pattern] =~ l
									@queue.add_link Link.new(l, link.url, link.depth + 1)
								end
							end
						end

						# add document to repository unless it is filtered
						unless @options[:filter] and @options[:filter].call(document)
							@repository.process_document(document)
						end
					end
				rescue => e
					puts "#{link.url}: #{e}"
				end

				# download limit reached?
				break if @options[:download_limit] and downloaded >= @options[:download_limit]
			end
		end
	end
end