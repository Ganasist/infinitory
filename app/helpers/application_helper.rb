module ApplicationHelper

	def title(page_title)
		content_for(:title) { "Infinitory | " + page_title }
	end

	def url_with_protocol(url)
    /^http/.match(url) ? url : "http://#{url}"
  end
	
	def badging(activity)
		if activity.key ==	"reagent.create"
			raw('<span class="badge">+1</span>')
		elsif activity.key == "reagent.update"
	  	raw('<span class="badge badge-warning">+2</span>')
	  elsif activity.key == "reagent.delete"              
	  	raw('<span class="badge">+3</span>')
	  end
	end
end
