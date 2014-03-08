class AverageDailyPointsWorker
  include Sidekiq::Worker
  include Sidetiq::Schedulable

  recurrence backfill: true do
    daily
  end
  
  def perform
    today = DateTime.now
    User.find_each do |t|
      if t.joined > 3.days.ago
      	t.daily_points = (t.points / (today - t.joined.to_datetime).to_i)
      	t.save
      end
    end
  end
end