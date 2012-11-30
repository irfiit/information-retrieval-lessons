require "rubygems"
require "bundler/setup"

require 'nokogiri'
require 'faraday'
require 'ferret'

require 'uri'
require 'fileutils'

module InformationRetrievalLessons

	module Analyzers
		autoload :SampleAnalyzer, File.expand_path('information-retrieval-lessons/analyzers/sample_analyzer', File.dirname(__FILE__))
	end

	module Crawlers
		autoload :Crawler, File.expand_path('information-retrieval-lessons/crawlers/crawler', File.dirname(__FILE__))
		autoload :BreadthFirstQueue, File.expand_path('information-retrieval-lessons/crawlers/breadth_first_queue', File.dirname(__FILE__))
		autoload :DepthFirstQueue, File.expand_path('information-retrieval-lessons/crawlers/depth_first_queue', File.dirname(__FILE__))
		autoload :Link, File.expand_path('information-retrieval-lessons/crawlers/link', File.dirname(__FILE__))
	end

	module Documents
		autoload :Document, File.expand_path('information-retrieval-lessons/documents/document', File.dirname(__FILE__))
		autoload :HtmlDocument, File.expand_path('information-retrieval-lessons/documents/html_document', File.dirname(__FILE__))
	end

	module Helpers
		autoload :LinkHelper, File.expand_path('information-retrieval-lessons/helpers/link_helper', File.dirname(__FILE__))
	end

	module Repositories
		autoload :DummyRepository, File.expand_path('information-retrieval-lessons/repositories/dummy_repository', File.dirname(__FILE__))
		autoload :FileRepository, File.expand_path('information-retrieval-lessons/repositories/file_repository', File.dirname(__FILE__))
		autoload :IndexRepository, File.expand_path('information-retrieval-lessons/repositories/index_repository', File.dirname(__FILE__))
		autoload :AnalyzeRepository, File.expand_path('information-retrieval-lessons/repositories/analyze_repository', File.dirname(__FILE__))
		autoload :ExtractRepository, File.expand_path('information-retrieval-lessons/repositories/extract_repository', File.dirname(__FILE__))
		autoload :SegmentizeRepository, File.expand_path('information-retrieval-lessons/repositories/segmentize_repository', File.dirname(__FILE__))
	end

	# load classes now
	Documents::HtmlDocument
end