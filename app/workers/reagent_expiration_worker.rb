class ReagentExpirationWorker
  include Sidekiq::Worker
  include Sidetiq::Schedulable
  sidekiq_options retry: false, backtrace: true
  
  recurrence backfill: true do
    daily
  end

  def perform
  	Reagent.expiration_notice
  	PaperTrail::Version.delete_all['created_at > ?', 1.month.ago]
  end
end
