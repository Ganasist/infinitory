module ApplicationHelper

	def title(page_title)
		content_for(:title) { "Infinitory | " + page_title }
	end

	def url_with_protocol(url)
    /^http/.match(url) ? url : "http://#{url}"
  end
	
	def badging(activity)
		if (activity.key == "reagent.create") || (activity.key == "device.create")
			raw('<span class="badge badge-1">+1</span>')
		elsif (activity.key == "reagent.update") || (activity.key == "device.update")
	  	raw('<span class="badge badge-2">+2</span>')
	  elsif (activity.key == "reagent.delete") || (activity.key == "device.delete")
	  	raw('<span class="badge badge-3">+3</span>')
	  elsif (activity.key == "reagent.clone") || (activity.key == "device.clone")
	   	raw('<span class="badge badge-4">+4</span>')
	  end
	end
end
