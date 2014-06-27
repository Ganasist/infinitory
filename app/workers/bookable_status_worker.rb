class BookableStatusWorker
	include Sidekiq::Worker
  sidekiq_options retry: true, backtrace: true

  def perform(item_id)

    if item.bookable?
      comment = "#{ item.fullname } is now bookable"
    else
      comment = "#{ item.fullname } is no longer bookable"
    end

    item.users.each do |u|
      u.comments.create(comment: comment)
    end
    item.lab.comments.create(comment: comment) 
  end
end