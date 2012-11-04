require File.expand_path('../lib/information-retrieval-lessons.rb', File.dirname(__FILE__))

repository = InformationRetrievalLessons::Repositories::DummyRepository.new
queue = InformationRetrievalLessons::Crawlers::DepthFirstQueue.new
crawler = InformationRetrievalLessons::Crawlers::Crawler.new(repository, queue)
crawler.crawl('http://irfiit.github.com/data/1.html')