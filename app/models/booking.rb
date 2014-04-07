class Booking < ActiveRecord::Base
	belongs_to :user, touch: true, counter_cache: :bookings_count 
  belongs_to :device, touch: true, counter_cache: :bookings_count



  def duration
  	if ((self.end_time - self.start_time)/60).to_i <= 120
	  	((self.end_time - self.start_time)/60).round(0).to_s + " min"
	  elsif 120 < ((self.end_time - self.start_time)/60).to_i && ((self.end_time - self.start_time)/60).to_i  <= 3600
	  	((self.end_time - self.start_time)/3600).round(1).to_s + " hrs"
	  elsif 3600 < ((self.end_time - self.start_time)/60).to_i
	  	((self.end_time - self.start_time)/86400).round(1).to_s + " days"
	  end	  	
  end

  def all_day?
    self.duration > 3600
  end

end
