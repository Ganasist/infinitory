class Lab < ActiveRecord::Base

	belongs_to :department
	belongs_to :institute

  validates :group_leader_email, uniqueness: true, presence: true
  validates_associated :institute

end
