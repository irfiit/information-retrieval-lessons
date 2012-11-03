module InformationRetrievalLessons
	module Documents
		class Document
			attr_accessor :url, :content_type, :size, :raw_body

			##
			#
			# Creates correct type of document.
			#
			# @param [String] url URL of document.
			# @param [Faraday::Response] response Faraday::Response object.
			#
			# @returns Correct subclass of Document based on content_type.
			#
			def self.from_url_and_response(url, response)
				# no error pages
				return nil unless response.status == 200 

				# create document
				content_type = response.headers['content-type']
				document = @@DOCUMENT_TYPES[content_type].new(response) 
				document.url = url
				document.content_type = content_type
				document.size = response.body.size
				document.raw_body = response.body
				document
			end

			protected

				@@DOCUMENT_TYPES = Hash.new(Document) # default class

				def self.register_document_type(type)
					@@DOCUMENT_TYPES[type] = self
				end

			private

				def initialize(response)
				end
		end
	end
end