class Booking < ActiveRecord::Base
	belongs_to :user, touch: true, counter_cache: :bookings_count 
  belongs_to :device, touch: true, counter_cache: :bookings_count

  before_update :set_all_day

  def duration_accurate
    end_time - start_time
  end

  def duration
  	if (duration_accurate / 60) <= 120
	  	(duration_accurate / 60).round(0).to_s + " min"
	  elsif 120 < (duration_accurate / 60) && (duration_accurate / 60)  <= 1440
	  	(duration_accurate / 3600).round(1).to_s + " hrs"
	  elsif 1440 < (duration_accurate / 60)
	  	(duration_accurate / 86400).round(1).to_s + " days"
	  end	  	
  end

  def set_all_day
    if self.duration_accurate > 86400
      self.all_day = true
    else
      self.all_day = false
      true
    end
  end
end
