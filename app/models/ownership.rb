class Ownership < ActiveRecord::Base
	belongs_to :user, touch: true, counter_cache: :devices_count, counter_cache: :reagents_count 
  belongs_to :reagent, touch: true
  belongs_to :device, touch: true

  # validates :user, :reagent, presence: true
end