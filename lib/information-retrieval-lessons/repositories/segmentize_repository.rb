require 'sanitize'

module InformationRetrievalLessons
	module Repositories
		class SegmentizeRepository

			def process_document(document)
				if document.kind_of? InformationRetrievalLessons::Documents::HtmlDocument
					nokogiri = Nokogiri::HTML(document.raw_body)
					segmentized = nokogiri.css('body').first.inner_html
					segmentized.gsub!(%r{<br>|<br/>}mi, "\n")
					segmentized.gsub!(%r{<li.*?>(.*?)</li>}mi, "- \\1")
					segmentized = Sanitize.clean(segmentized)
					segmentized.gsub!(%r{^- \n+}mi, "- ")
					puts segmentized
				end
			end
		end
	end
end