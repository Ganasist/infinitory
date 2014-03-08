class AverageDailyPointsWorker
  include Sidekiq::Worker
  include Sidetiq::Schedulable

  recurrence backfill: true do
    daily
  end
  
  def perform
    today = DateTime.now
    User.where('joined < ?', 2.days.ago).find_in_batches do |b|
      b.each do |u|
      	u.daily_points = (u.points / (today - u.joined.to_datetime).to_i)
      	u.save
      end
    end
  end
end