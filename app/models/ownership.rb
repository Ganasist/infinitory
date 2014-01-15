class Ownership < ActiveRecord::Base
	belongs_to :user, touch: true, counter_cache: true
  belongs_to :reagent, touch: true, counter_cache: true
  belongs_to :device, touch: true, counter_cache: true

  # validates :user, :reagent, presence: true
end
