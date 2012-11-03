module InformationRetrievalLessons
	module Repositories
		
		##
		#
		# Perform analysis (tokenization and filtering) on input documents.
		#
		class AnalyzeRepository

			##
			#
			# Create a new AnalyzeRepository.
			#
			# @param [Ferret::Analysis::Analyzer] analyzer Analyzer used to process documents.
			#
			# Analyzer examples:
			#
			# 	InformationRetrievalLessons::Analyzers::SampleAnalyzer
			# 	Ferret::Analysis::AsciiLetterAnalyzer
			# 	Ferret::Analysis::AsciiStandardAnalyzer
			# 	Ferret::Analysis::AsciiWhiteSpaceAnalyzer
			# 	Ferret::Analysis::LetterAnalyzer
			# 	Ferret::Analysis::RegExpAnalyzer
			# 	Ferret::Analysis::StandardAnalyzer
			# 	Ferret::Analysis::WhiteSpaceAnalyzer
			#
			def initialize(analyzer)
				@analyzer = analyzer
			end

			def process_document(document)
				token_stream = @analyzer.token_stream('body', document.raw_body)
				
				puts document.url
				while (n = token_stream.next)
					print "#{n.text} * "
				end
				puts
				puts '----------------'
			end
		end
	end
end