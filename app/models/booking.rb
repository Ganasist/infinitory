class Booking < ActiveRecord::Base
	belongs_to :user, touch: true, counter_cache: :bookings_count 
  belongs_to :device, touch: true, counter_cache: :bookings_count


  def duration_min
  	(self.end_time - self.start_time)/60
  end

  def duration_hr
  	(self.end_time - self.start_time)/3600
  end
end
