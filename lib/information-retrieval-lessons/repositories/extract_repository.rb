module InformationRetrievalLessons
	module Repositories
		class ExtractRepository

			def initialize(regexp)
				@regexp = regexp
			end

			def process_document(document)
				puts document.url
				document.raw_body.scan(@regexp) do |result|
					print "#{result} * "
				end
				puts
				puts '-------------'
			end
		end
	end
end