class ReagentDeviceIndexWorker
  include Sidekiq::Worker
  include Sidetiq::Schedulable

  # sidekiq_options retry: false, backtrace: true
  
  recurrence backfill: true do
    daily
  end
  
  def perform
  	Reagent.find_each(&:touch)
    Device.find_each(&:touch)
  end
end