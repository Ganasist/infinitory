class ReagentDeviceIndexWorker
  include Sidekiq::Worker
  include Sidetiq::Schedulable

  recurrence backfill: true do
    daily.hour_of_day(1)
  end
  
  def perform
  	Reagent.find_each(&:touch)
    Device.find_each(&:touch)
  end
end