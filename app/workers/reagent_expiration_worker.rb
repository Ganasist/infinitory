class ReagentExpirationWorker
  include Sidekiq::Worker
  include Sidetiq::Schedulable
  # sidekiq_options retry: false, backtrace: true
  
  recurrence { minutely.second_of_minute(0,15,30,45) }

  def perform
  	Reagent.expiration_notice
  end
end
