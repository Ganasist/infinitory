class ReagentExpirationWorker
  include Sidekiq::Worker
  include Sidetiq::Schedulable
  
  # sidekiq_options retry: false, backtrace: true
  
  recurrence { minutely }

  def perform
  	Reagent.expiration_notice
  end
end
