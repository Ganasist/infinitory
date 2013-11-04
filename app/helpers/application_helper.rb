module ApplicationHelper

	def title(page_title)
		content_for(:title) { "Infinitory | " + page_title }
	end
	
end
