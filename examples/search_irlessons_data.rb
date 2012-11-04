require File.expand_path('../lib/information-retrieval-lessons.rb', File.dirname(__FILE__))

repository = InformationRetrievalLessons::Repositories::IndexRepository.new('tmp/index-irlessons-data/')

print "Query: "
query = gets

hits = repository.search("body:\"#{query}\"") do |document, score|
	puts "#{document[:url]} #{score}"
end
puts "Found #{hits} documents."