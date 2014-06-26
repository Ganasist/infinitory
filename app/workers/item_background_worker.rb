class ItemBackgroundWorker
  include Sidekiq::Worker
  sidekiq_options retry: true, backtrace: true
  

  def perform(type, item_id, action, current_user_id)
  	current_user = User.find(current_user_id)
  	
  	if type == "reagent"
	  	item = Reagent.find(item_id)
	  elsif type == "device" || type == "booking"
	  	item = Device.find(item_id)
	  end	

    if type == "reagent" || type == "device"
    	if item.location.present?
        item.users.each do |u|
          u.comments.create(comment: "#{ item.fullname } (#{ item.location }) was #{ action } by #{ current_user.fullname }")
        end
        item.lab.comments.create(comment: "#{ item.fullname } (#{ item.location }) was #{ action } by #{ current_user.fullname }")
      else
        item.users.each do |u|
          u.comments.create(comment: "#{ item.fullname } was #{ action } by #{ current_user.fullname }")
        end
        item.lab.comments.create(comment: "#{ item.fullname } was #{ action } by #{ current_user.fullname }")
      end
    elsif type == "booking"
      item.users.each do |u|
        u.comments.create(comment: "#{ current_user.fullname } #{ action } a booking for #{ item.fullname } (#{ item.location })")
      end
      item.lab.comments.create(comment: "#{ current_user.fullname } #{ action } a booking for #{ item.fullname } (#{ item.location })")
    else
      item.users.each do |u|
        u.comments.create(comment: "#{ current_user.fullname } #{ action } a booking for #{ item.fullname }")
      end
      item.lab.comments.create(comment: "#{ current_user.fullname } #{ action } a booking for #{ item.fullname }")
    end
  end
end
