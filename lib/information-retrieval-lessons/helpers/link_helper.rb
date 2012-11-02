module InformationRetrievalLessons
	module Helpers
		module LinkHelper

			def is_url?(u)
				not (u.start_with?('#') or u.start_with?('javascript:') or u.start_with?('mailto:'))
			end
		end
	end
end