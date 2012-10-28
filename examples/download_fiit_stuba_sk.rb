Dir[File.expand_path('../lib/**/*.rb', File.dirname(__FILE__))].each { |f| require f }

repository = Repositories::FileRepository.new('tmp/download-fiit-stuba-sk/')
queue = Crawlers::BreadthFirstQueue.new
#crawler = Crawlers::Crawler.new(repository, queue, filter: lambda { |document| document.size > 10000 })
crawler = Crawlers::Crawler.new(repository, queue, 
								url_pattern: %r{\Ahttp://www\.fiit\.stuba\.sk})
crawler.crawl('http://www.fiit.stuba.sk/')