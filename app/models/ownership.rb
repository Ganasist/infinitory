class Ownership < ActiveRecord::Base
	belongs_to :user
  belongs_to :reagent

  # validates :user, :reagent, presence: true
end
