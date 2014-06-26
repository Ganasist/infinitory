class ReagentExpirationWorker
  include Sidekiq::Worker
  include Sidetiq::Schedulable

  recurrence backfill: true do
    daily
  end

  def perform
  	Reagent.expiration_notice
  end
end