class Ownership < ActiveRecord::Base
	belongs_to :user, touch: true
  belongs_to :reagent, touch: true
  belongs_to :device, touch: true

  # validates :user, :reagent, presence: true
end
