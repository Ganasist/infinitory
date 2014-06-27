class BookableStatusWorker
	include Sidekiq::Worker
  sidekiq_options retry: false, backtrace: true

  def perform(item_id)

    device = Reagent.find(item_id)

    if device.bookable?
      comment = "#{ item.fullname } is now bookable"
    else
      comment = "#{ item.fullname } is no longer bookable"
    end

    device.users.each do |u|
      u.comments.create(comment: comment)
    end
    device.lab.comments.create(comment: comment) 
  end
end