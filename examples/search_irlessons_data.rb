require File.expand_path('../lib/information-retrieval-lessons.rb', File.dirname(__FILE__))

repository = InformationRetrievalLessons::Repositories::IndexRepository.new('tmp/index-irlessons-data/')

print "Query: "
query = gets

hits = repository.search(query) do |document, score|
	puts "#{document[:url]} (score #{score})"
	puts "#{document[:title]}"
	puts "----------------------------"
end
puts "Found #{hits} documents."