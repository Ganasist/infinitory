class BookingValidator < ActiveModel::Validator

	def validate(record)
		record.errors[:end_time] << 'must be later than start time!' unless :start_time < :end_time
	end

end