class Ownership < ActiveRecord::Base
	belongs_to :user
  belongs_to :reagent
  belongs_to :device

  # validates :user, :reagent, presence: true
end
