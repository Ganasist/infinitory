class ReagentExpirationWorker
  include Sidekiq::Worker
  include Sidetiq::Schedulable

  recurrence backfill: true do
    daily
  end

  def perform
  	Reagent.where(expiration: [28.days.from_now, 14.days.from_now]).find_in_batches(batch_size: 50) do |reagents|
      reagents.each do |reagent|
        reagent.users.each do |u|
		      u.comments.create(comment: "#{ reagent.fullname } expires soon. Consider sharing it.")
		    end
		    reagent.lab.comments.create(comment: "#{ reagent.fullname } expires soon. Consider sharing it.")
			end
    end
  end
end