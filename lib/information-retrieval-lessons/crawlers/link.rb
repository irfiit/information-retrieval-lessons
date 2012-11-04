module InformationRetrievalLessons
	module Crawlers
		class Link
			attr_accessor :uri, :from_uri, :depth

			def initialize(uri, from_uri = nil, depth = 0)
				@uri = URI(URI.encode(uri))
				if from_uri
					@from_uri = URI(URI.encode(from_uri))
					unless @uri.scheme
						@uri.scheme = @from_uri.scheme
						@uri.userinfo = @from_uri.userinfo
						@uri.host = @from_uri.host
						@uri.port = @from_uri.port if @from_uri.port != 80
						@uri.registry = @from_uri.registry
						unless @uri.path.start_with?('/')
							@uri.path = "#{@from_uri.path.sub(/\/[^\/]+\z/, '')}/#{@uri.path}" 
						end
					end
				end
				@uri.fragment = nil
				@depth = depth
			end

			def ==(l)
				uri.scheme == l.uri.scheme \
					and uri.host == l.uri.host \
					and uri.port == l.uri.port \
					and uri.path == l.uri.path \
					and uri.query == l.uri.query \
			end

			def url
				uri.to_s
			end
		end
	end
end