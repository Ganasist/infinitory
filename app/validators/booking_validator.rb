class BookingValidator < ActiveModel::Validator

	def validate(record)
		record.errors[:end_time] << 'must be after start time!' unless booking_direction(record)
		record.errors[:device_id] << 'must belong to your lab' unless user_device_lab(record)
	end

	def booking_direction(record)
		unless record[:start_time].blank? || record[:end_time].blank? 
			record[:start_time] < record[:end_time]
		end
	end

	def user_device_lab(record)
		unless record[:device_id].blank? || record[:user_id].blank?
			Device.find(record[:device_id]).lab == User.find(record[:user_id]).lab
		end
	end

end