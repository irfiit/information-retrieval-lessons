module InformationRetrievalLessons
	module Repositories
		class DummyRepository

			def process_document(document)
				if document.respond_to? :title
					puts "#{document.url}: #{document.title}"
				else
					puts "#{document.url}: #{document.content_type}"
				end
			end
		end
	end
end