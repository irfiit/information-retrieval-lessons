require 'nokogiri'
require './lib/helpers/link_helper'

module Documents

	class HtmlDocument < Document
		attr_accessor :title, :body, :urls

		register_document_type 'text/html'
		register_document_type 'application/xhtml+xml'

		include ::Helpers::LinkHelper

		def initialize(response)
			nokogiri = Nokogiri::HTML(response.body)
			@title = nokogiri.css('title').first.content
			@body = nokogiri.css('body').first.content
			@urls = []
			nokogiri.css('a[href]').each do |a|
				u = a[:href]
				@urls << u if is_url?(u) 
			end
		end
	end
end