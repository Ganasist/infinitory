class Lab < ActiveRecord::Base

	belongs_to :department
	belongs_to :institute

	has_many 	 :users, dependent: :destroy

	validates :group_leader, :institute, presence: true

  # validates :email, uniqueness: true, presence: true,
  # 					format: { :with => /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]+\z/,
  #                    :message => 'Invalid e-mail! Please provide a valid e-mail address'}

  validates_presence_of :institute
  validates_associated :department

end
