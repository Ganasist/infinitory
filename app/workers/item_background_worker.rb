class ItemBackgroundWorker
  include Sidekiq::Worker
  sidekiq_options retry: false, backtrace: true
  

  def perform(type, item_id, action, current_user_id)
  	current_user = User.find(current_user_id)
  	
  	if type == "reagent"
	  	item = Reagent.find(item_id)
	  elsif type == "device"
	  	item = Device.find(item_id)
	  end	

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
  end
end
