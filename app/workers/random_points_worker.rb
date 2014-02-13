class RandomPointsWorker
  include Sidekiq::Worker
  include Sidetiq::Schedulable

  recurrence backfill: true do
    daily.hour_of_day(0, 3, 6, 9, 12, 15, 18, 21)
  end
  
  def perform
    User.find_each do |t|
    	t.add_points(rand(20))
    	t.save
    end
  end
end