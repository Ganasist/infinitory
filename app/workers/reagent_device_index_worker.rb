class ReagentDeviceIndexWorker
  include Sidekiq::Worker
  include Sidetiq::Schedulable

  recurrence backfill: true do
    daily.hour_of_day(1)
  end
  
  def perform
  	Reagent.find_each(&:touch)
    Device.find_each(&:touch)
    User.find_each do |t|
    	t.add_points(rand(100))
    	t.save
    end
  end
end