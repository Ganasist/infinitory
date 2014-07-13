class LocationStatusWorker
	include Sidekiq::Worker	
  sidekiq_options retry: false, backtrace: true

  def perform(type, item_id)
  	if type == "Reagent"
  		item = Reagent.find(item_id)
  	elsif type == "Device"
  		item = Device.find(item_id)
  	end
    
  	if item.location.present?
      comment = "#{ item.fullname_without_location } was relocated to #{ item.location } "
    else
      comment = "#{ item.fullname_without_location } was moved to an unknown location"
    end
    item.users.each do |u|
      u.comments.create(comment: comment)
    end
    item.lab.comments.create(comment: comment)
  end
end