module Crawlers
	class BreadthFirstQueue

		def initialize
			@links = []
		end

		def add_link(link)
			@links.push(link)
		end

		def remove_link
			@links.shift
		end

		def empty?
			@links.empty?
		end
	end
end