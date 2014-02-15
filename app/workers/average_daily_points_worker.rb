class AverageDailyPointsWorker
  include Sidekiq::Worker
  include Sidetiq::Schedulable

  recurrence backfill: true do
    daily
  end
  
  def perform
    User.find_each do |t|
    	t.points
    	t.save
    end
  end
end