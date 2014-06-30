class BookableStatusWorker
	include Sidekiq::Worker
  sidekiq_options retry: true, backtrace: true

  def perform(item_id)

    device = Device.find(item_id)

    if device.bookable?
      comment = "#{ device.fullname } was made bookable"
    else
      comment = "#{ device.fullname } was made not bookable"
    end

    device.users.each do |u|
      u.comments.create(comment: comment)
    end
    device.lab.comments.create(comment: comment) 
  end
end