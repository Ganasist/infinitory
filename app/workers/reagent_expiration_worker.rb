class ReagentExpirationWorker
  include Sidekiq::Worker
  include Sidetiq::Schedulable

  # sidekiq_options retry: false, backtrace: true
  
  recurrence backfill: true do
    daily
  end
  
  def perform
  	Reagent.expiration_notice
  	Comment.destroy_all ['created_at < ?', 3.months.ago]
  	# PublicActivity::Activity.destroy_all ['created_at < ?', 3.months.ago]
  end
end