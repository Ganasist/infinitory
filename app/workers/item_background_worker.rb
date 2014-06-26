class ItemBackgroundWorker
  include Sidekiq::Worker
  sidekiq_options retry: true, backtrace: true
  
  def perform(type, item_id, action, current_user_id)
    if type == "reagent"
      item = Reagent.find(item_id)
    elsif type == "device" || type == "booking"
      item = Device.find(item_id)
    end
    current_user = User.find(current_user_id)  		

    if type == "reagent" || type == "device"
    	if item.location.present?
        comment = "#{ item.fullname } (#{ item.location }) was #{ action } by #{ current_user.fullname }"
      else
        comment = "#{ item.fullname } was #{ action } by #{ current_user.fullname }"
      end
    elsif type == "booking"
      if item.location.present?
        comment = "#{ current_user.fullname } #{ action } a booking for #{ item.fullname } (#{ item.location })"
      else
        comment = "#{ current_user.fullname } #{ action } a booking for #{ item.fullname }"
      end
    end
    item.users.each do |u|
      u.comments.create(comment: comment)
    end
    item.lab.comments.create(comment: comment)
  end
end
