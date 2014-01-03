class Ownership < ActiveRecord::Base
	belongs_to :user
  belongs_to :reagent, counter_cache: :reagents_count, touch: true
  belongs_to :device, counter_cache: :devices_count, touch: true

  # validates :user, :reagent, presence: true
end
