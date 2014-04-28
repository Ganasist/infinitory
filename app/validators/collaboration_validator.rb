class CollaborationValidator < ActiveModel::Validator

	def validate(record)
		record.errors[:lab_email] << 'You cannot collaborate with yourself!' unless self_collaboration_check(record)
		# record.errors[:device_id] << 'must belong to your lab' unless user_device_lab(record)
	end

	def self_collaboration_check(record)
		unless record[:lab_email].blank?
			Lab.find(record[:lab_email]) != Lab.find(record[:lab_id])
		end
	end

end