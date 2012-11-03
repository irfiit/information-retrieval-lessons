module InformationRetrievalLessons
	module Analyzers
		class SampleAnalyzer < Ferret::Analysis::Analyzer
			def token_stream(field_name, input)
				tokenizer = Ferret::Analysis::WhiteSpaceTokenizer.new(input)
				tokenizer = Ferret::Analysis::LowerCaseFilter.new(tokenizer)
				tokenizer = Ferret::Analysis::StopFilter.new(tokenizer, %w{a i alebo})
				tokenizer
			end
		end
	end
end