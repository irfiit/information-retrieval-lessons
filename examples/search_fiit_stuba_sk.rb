require File.expand_path('../lib/information-retrieval-lessons.rb', File.dirname(__FILE__))

repository = InformationRetrievalLessons::Repositories::IndexRepository.new('tmp/index-fiit-stuba-sk/')

print "Query: "
query = gets

hits = repository.search("body:\"#{query}\"") do |document, score|
	if document[:title]
    	puts "#{document[:title]} #{score}"
    else
    	puts "#{document[:url]} #{score}"
    end
end
puts "Found #{hits} documents."