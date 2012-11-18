require File.expand_path('../lib/information-retrieval-lessons.rb', File.dirname(__FILE__))

repository = InformationRetrievalLessons::Repositories::IndexRepository.new('tmp/index-fiit-stuba-sk/')
queue = InformationRetrievalLessons::Crawlers::BreadthFirstQueue.new
#crawler = Crawlers::Crawler.new(repository, queue, filter: lambda { |document| document.size > 10000 })
crawler = InformationRetrievalLessons::Crawlers::Crawler.new(repository, queue, 
								url_pattern: %r{\Ahttp://www\.fiit\.stuba\.sk})
crawler.crawl('http://www.fiit.stuba.sk/')