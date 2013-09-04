class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :lockable, and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable, :timeoutable

  belongs_to :institute
  belongs_to :department
  belongs_to :lab

  validates_associated :lab

  before_validation :create_lab
  # validates_presence_of :lab, message: "Your group leader must create an account first"

  ROLES = %w[group_leader lab_manager lab_member]

  def role_symbols
	  [role.to_sym]
	end

	def department_name
    department.try(:name)
  end
  
  def department_name=(email)
    self.department = department.find_or_create_by(name) if name.present?
  end

	def institute_name
    institute.try(:name)
  end
  
  def institute_name=(email)
    self.institute = Institute.find_or_create_by(name) if name.present?
  end

  def create_lab
  	if self.role.group_leader?
	  	self.lab = Lab.create(email: self.email, department: self.department, institute: self.institute)
  	end
  end

end
