class OnlineStatusWorker
	include Sidekiq::Worker
  sidekiq_options retry: true, backtrace: true

  def perform(item_id)
  	item = Device.find(item_id)
  	if item.location.present?
      if item.status?
        comment = "#{ item.fullname } (#{ item.location }) was taken online"
      else
        comment = "#{ item.fullname } (#{ item.location }) was taken offline"
      end
    else
      if item.status?
        comment = "#{ item.fullname } was taken online"
      else
        comment = "#{ item.fullname } was taken offline"
      end
    end
    item.users.each do |u|
      u.comments.create(comment: comment)
    end
    item.lab.comments.create(comment: comment)
  end
end