module InformationRetrievalLessons
	module Crawlers
		##
		#
		# LIFO-based crawling.
		#
		class DepthFirstQueue

			def initialize
				@links = []
			end

			def add_link(link)
				@links.push(link)
			end

			def remove_link
				@links.pop
			end

			def empty?
				@links.empty?
			end
		end
	end
end