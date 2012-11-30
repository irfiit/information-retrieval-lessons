module InformationRetrievalLessons
	module Repositories
		##
		#
		# Performs extraction on input documents.
		#
		class ExtractRepository

			##
			#
			# Create a new ExtractRepository.
			#
			# ==== Parameters
			#
			# - [RegExp] regexp Regular expression to scan for in input documents.
			#
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