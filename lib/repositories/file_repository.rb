require 'fileutils'

module Repositories
	class FileRepository

		def initialize(path)
			@path = path
		end

		def process_document(document)
			uri = URI(document.url)
			
			# bucketize by hostname
			path = File.expand_path(URI.encode(uri.host), @path)
			FileUtils.mkpath(path)

			filename = URI.encode(uri.query || uri.host)
			open(File.expand_path(filename, path), 'w') do |file|
				file.write(document.raw_body)
			end
		end
	end
end