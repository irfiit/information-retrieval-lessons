require File.expand_path('../lib/information-retrieval-lessons.rb', File.dirname(__FILE__))

repository = InformationRetrievalLessons::Repositories::ExtractRepository.new(
	/[_a-z0-9-]+(?:\.[_a-z0-9-]+)*@[a-z0-9-]+(?:\.[a-z0-9-]+)*(?:\.[a-z]{2,4})/i
)
queue = InformationRetrievalLessons::Crawlers::BreadthFirstQueue.new
crawler = InformationRetrievalLessons::Crawlers::Crawler.new(repository, queue)
crawler.crawl('http://irfiit.github.com/data/1.html')