class Booking < ActiveRecord::Base

  paginates_per 8
  scope :end_time_desc, -> { order("end_time Desc") }

	belongs_to :user, touch: true, counter_cache: :bookings_count 
  belongs_to :device, touch: true, counter_cache: :bookings_count

  before_save :set_all_day

  validates :user_id, :device_id, :start_time, :end_time, presence: true

  validates :start_time, :end_time, overlap: { scope: "device_id", exclude_edges: ["start_time", "end_time"], message_content: "Overlaps with another booking, please pick a different time!" }

  validates_with BookingValidator

  def duration_accurate
    end_time - start_time
  end

  def duration
  	if (duration_accurate / 60) <= 120
	  	(duration_accurate / 60).round(0).to_s + ' min'
	  elsif 120 < (duration_accurate / 60) && (duration_accurate / 60) < 2880
	  	(duration_accurate / 3600).round(1).to_s + ' hrs'
	  elsif 2880 <= (duration_accurate / 60)
	  	(duration_accurate / 86400).round(1).to_s + ' days'
	  end	  	
  end

  def in_progress?
    (self.start_time < Time.now) && (Time.now < self.end_time)
  end


  def finished?
    self.end_time < Time.now
  end

  def expired_one_day?
    self.end_time < 1.day.ago
  end

  private
    def set_all_day
      if self.duration_accurate > 86400
        self.all_day = true
      else
        self.all_day = false
        true
      end
    end
end
