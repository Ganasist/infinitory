class GroupLeader < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, 
  			 :trackable, :validatable, :lockable, :timeoutable

  has_one :lab, inverse_of: :group_leader, dependent: :destroy
  accepts_nested_attributes_for :lab
  after_create :create_lab

  belongs_to :department
  belongs_to :institute

  validates_presence_of :institute

  def institute_name
    institute.try(:name)
  end

  def institute_name=(name)
    self.institute = Institute.find_or_create_by(name: name) if name.present?
  end

  def department_name
    department.try(:name)
  end

  def department_name=(name)
    self.department = Department.find_or_create_by(name: name) if name.present?
  end


  def create_lab
    Lab.create(institute_id: self.institute_id, department_id: self.department_id, group_leader_id: self.id, email: self.email)
  end

end
