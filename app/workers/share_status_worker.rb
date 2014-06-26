class ShareStatusWorker
	include Sidekiq::Worker
  sidekiq_options retry: true, backtrace: true

  def perform(type, item_id)

  	if type == "reagent"
	  	item = Reagent.find(item_id)
	  elsif type == "device"
	  	item = Device.find(item_id)
	  end

  	if item.location.present?
      if item.shared?
        comment = "#{ item.fullname } (#{ item.location }) was shared"
      else
        comment = "#{ item.fullname } (#{ item.location }) was unshared"
      end
    else
      if item.shared?
        comment = "#{ item.fullname } was shared"
      else
        comment = "#{ item.fullname } was unshared"
      end
    end
    item.users.each do |u|
      u.comments.create(comment: comment)
    end
    item.lab.comments.create(comment: comment) 
  end
end