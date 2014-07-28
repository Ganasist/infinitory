# Included in Device, Reagent
module ItemShareAndLocation
	extend ActiveSupport::Concern
	extend ActiveModel::Naming

	included do
		after_commit :share_status_worker, on: :update, if: Proc.new { |i| i.previous_changes.include?(:shared) }
		after_commit :location_status_worker, on: :update, if: Proc.new { |i| i.previous_changes.include?(:location) }
	end

  def share_status_worker
    ShareStatusWorker.perform_async(self.class.name, self.id)
  end
  def location_status_worker
    LocationStatusWorker.perform_async(self.class.name, self.id)
  end
end