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
				@index = Ferret::Index::Index.new(options)

				if @index.size == 0 # new index?
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

				ferret_document[:anchor_text] = document.anchor_text

				# delete old document
				found_id = nil
				@index.search_each("url: \"#{document.url}\"") { |id, doc|
					found_id = id
				}
				@index.delete(found_id) if found_id

				@index << ferret_document
			end

			def add_anchor_text(url, anchor_text)
				found_id = nil
				@index.search_each("url: \"#{url}\"") { |id, doc|
					found_id = id
				}

				# modify document
				if found_id
					document = @index[found_id].load
					@index.delete(found_id)
					document[:anchor_text] = "#{document[:anchor_text].force_encoding('UTF-8')} #{anchor_text}"
					@index << document
				end
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