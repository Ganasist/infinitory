module ApplicationHelper

	def title(page_title)
		content_for(:title) { "Infinitory | " + page_title }
	end

	def url_with_protocol(url)
    /^http/.match(url) ? url : "http://#{url}"
  end
	
	def badging(activity)
		if (activity.key == "reagent.create") || (activity.key == "device.create")
			raw('<span class="badge badge-1 pull-right">+1</span>')
		elsif (activity.key == "reagent.update") || (activity.key == "device.update")
	  	raw('<span class="badge badge-2 pull-right">+2</span>')
	  elsif (activity.key == "reagent.delete") || (activity.key == "device.delete")
	  	raw('<span class="badge badge-3 pull-right">+3</span>')
	  elsif (activity.key == "reagent.clone") || (activity.key == "device.clone")
	   	raw('<span class="badge badge-4 pull-right">+4</span>')
	  elsif (activity.key == "user.feedback")
	   	raw('<span class="badge badge-5 pull-right">+5</span>')
	  elsif (activity.key == "user.invitation")
	   	raw('<span class="badge badge-10 pull-right">+10</span>')
	  elsif (activity.key == "user.gl_invitation")
	   	raw('<span class="badge badge-25 pull-right">+25</span>')
	  end
	end
end