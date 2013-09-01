class GroupLeader < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, 
  			 :trackable, :validatable, :lockable, :timeoutable

  has_one :lab, dependent: :destroy
  accepts_nested_attributes_for :lab
  after_create :create_lab

  belongs_to :department
  belongs_to :institute

  validates_presence_of :institute

  def create_lab
    Lab.create(institute_id: self.institute_id, group_leader_id: self.id, email: self.email)
  end

end
