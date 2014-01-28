class ReagentExpirationWorker
  include Sidekiq::Worker
  # include Sidetiq::Schedulable

  # recurrence backfill: true do
  #   daily
  # end

  def perform
  	Reagent.expiration_notice
  	Comment.destroy_all ['created_at < ?', 6.months.ago]
  	# PublicActivity::Activity.destroy_all ['created_at < ?', 3.months.ago]
  end
end