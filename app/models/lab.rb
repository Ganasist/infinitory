class Lab < ActiveRecord::Base
	belongs_to :department
	belongs_to :institute

	has_many 	 :users, dependent: :destroy
	belongs_to :group_leader

	validates_presence_of :group_leader
end
