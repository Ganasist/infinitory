class Lab < ActiveRecord::Base

	belongs_to :department
	belongs_to :institute

	has_many 	 :users, dependent: :destroy
	has_one		 :group_leader, dependent: :destroy

  # validates_presence_of :institute
  # validates_presence_of :group_leader

  validates_associated :department

end
