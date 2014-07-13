module ItemShareAndLocation
	extend ActiveSupport::Concern
	extend ActiveModel::Naming

	included do
		after_save :share_status_worker, if: Proc.new { |i| i.shared_changed? }
		after_update :location_status_worker, if: Proc.new { |i| i.location_changed? }
	end

  def share_status_worker
    ShareStatusWorker.delay_for(3.seconds).perform_async(self.class.name, self.id)
  end
  def location_status_worker
    LocationStatusWorker.delay_for(3.seconds).perform_async(self.class.name, self.id)
  end
end