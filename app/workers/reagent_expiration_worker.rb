class ReagentExpirationWorker
  include Sidekiq::Worker
  include Sidetiq::Schedulable

  # sidekiq_options retry: false, backtrace: true
  
  recurrence backfill: true do
    daily
  end
  
  def perform
  	Reagent.expiration_notice
  	Comment.where('created_at > ?', 30.days.ago).destroy_all
  	PublicActivity::Activity.where('created_at > ?', 3.months.ago).destroy_all
  end
end
