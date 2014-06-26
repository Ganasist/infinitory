class LocationStatusWorker
	include Sidekiq::Worker	
  sidekiq_options retry: true, backtrace: true

  def perform(type, item_id)
  	if type == "reagent"
  		item = Reagent.find(item_id)
  	elsif type == "device"
  		item = Device.find(item_id)
  	end

  	if item.location.present?
      comment = "#{ item.fullname } was moved to #{ item.location }"
    else
      comment = "#{ item.fullname } was moved to an unknown location"
    end
    item.users.each do |u|
      u.comments.create(comment: comment)
    end
    item.lab.comments.create(comment: comment)
  end
end