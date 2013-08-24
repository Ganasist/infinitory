class Lab < ActiveRecord::Base

	belongs_to :department
	belongs_to :institute

	validates :group_leader, presence: true
  validates :group_leader_email, uniqueness: true, presence: true,
  					format: { :with => /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]+\z/,
                     :message => 'Invalid e-mail! Please provide a valid e-mail address'}

  validates_associated :institute, presence: true
  validates_associated :department

end
