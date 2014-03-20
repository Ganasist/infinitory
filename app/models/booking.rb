class Booking < ActiveRecord::Base
	belongs_to :user, touch: true, counter_cache: :bookings_count 
  belongs_to :device, touch: true

  # validates :user, :reagent, presence: true
end