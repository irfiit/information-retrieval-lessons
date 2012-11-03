module InformationRetrievalLessons
	module Repositories
		##
		#
		# Indexes input documents.
		#
		class IndexRepository

			##
			#
			# Create a new IndexRepository.
			#
			# @param [String] path Path to store index (created if doesn't exist). Index is stored in memory if path is nil. 
			# @param [Hash] options Options passed to Ferret::Index::Index.new.
			#
			def initialize(path = nil, options = {})
				options.merge! path: path if path
				options.merge! key: :url
				@index = Ferret::Index::Index.new(options)

				if @index.size == 0 # new index?
					@index.field_infos.add_field(:url, index: :no, :term_vector => :no)
					@index.field_infos.add_field(:content_type, index: :no, :term_vector => :no)
					@index.field_infos.add_field(:raw_body, index: :no, :term_vector => :no)
					@index.field_infos.add_field(:size, index: :no, :term_vector => :no)
				end
			end

			def process_document(document)
				ferret_document = {}

				ferret_document[:url] = document.url
				ferret_document[:content_type] = document.content_type
				ferret_document[:raw_body] = document.raw_body
				ferret_document[:size] = document.size

				ferret_document[:title] = document.title if document.respond_to?(:title)
				ferret_document[:body] = document.body if document.respond_to?(:body)

				@index << ferret_document
			end

			##
			#
			# Search for query in index.
			#
			# @param [String] query Query string using Ferret query syntax.
			# @param [Proc] &block Block executed for each found document. Document (Ferret::Index::LazyDoc) and score (Integer) are passed to the block. 
			#
			# @returns Number of found documents.
			#
			def search(query, &block)
				@index.search_each(query) do |id, score|
					yield @index[id], score
				end
			end
		end
	end
end