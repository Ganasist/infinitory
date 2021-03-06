module ApplicationHelper

	def title(page_title)
		content_for(:title) { "Infinitory | " + page_title }
	end

	def url_with_protocol(url)
    /^http/.match(url) ? url : "http://#{url}"
  end
	
	def badging(activity)
		if (activity.key == "user.feedback")
			raw('<span class="badge badge-1 pull-right">+1</span>')
		elsif (activity.key == "reagent.update") ||
					(activity.key == "device.update") || 
					(activity.key == "booking.update")
			raw('<span class="badge badge-2 pull-right">+2</span>')
		elsif (activity.key == "reagent.create") ||
					(activity.key == "device.create") ||
					(activity.key == "booking.create")
	  	raw('<span class="badge badge-3 pull-right">+3</span>')
	  elsif (activity.key == "reagent.clone") ||
	  			(activity.key == "device.clone")
	  	raw('<span class="badge badge-4 pull-right">+4</span>')
	  elsif (activity.key == "reagent.delete") ||
	  			(activity.key == "device.delete") ||
	  			(activity.key == "booking.delete")
	   	raw('<span class="badge badge-5 pull-right">+5</span>')
	  elsif (activity.key == "user.invitation")
	   	raw('<span class="badge badge-10 pull-right">+10</span>')
	  elsif (activity.key == "user.gl_invitation")
	   	raw('<span class="badge badge-25 pull-right">+25</span>')
	  end
	end

	def reagent_sortable(column, title = nil)
    title ||= column.titleize
    direction = (column == reagent_sort_column && reagent_sort_direction == 'asc') ? 'desc' : 'asc'
    link_to title, sort: column, direction: direction, remote: true
  end

  def device_sortable(column, title = nil)
    title ||= column.titleize
    direction = (column == device_sort_column && device_sort_direction == 'asc') ? 'desc' : 'asc'
    link_to title, sort: column, direction: direction, remote: true
  end
end