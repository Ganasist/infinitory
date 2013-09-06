class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :lockable, and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable, :timeoutable

  belongs_to :institute
  belongs_to :department
  belongs_to :lab

  validates_presence_of :lab, message: "Your group leader must create an account first"
  validates_uniqueness_of :email

  before_create :create_lab
  before_create  :affiliations
  
  ROLES = %w[group_leader lab_manager lab_member]

  # def role_symbols
	#   [role.to_sym]
	# end

  # def unique_gl?
  #   if self.role != "group_leader"
  #     false
  #   end
  # end

  def affiliations
    if self.role? != "group_leader"
      self.institute_id = lab.institute_id
      self.department_id = lab.department_id
    end
  end

  def gl
    role.where(role: "group_leader")
  end

  def department_name
    department.try(:name)
  end
  
  def department_name=(name)
    self.department = Department.find_or_create_by(name: name, institute_id: self.institute_id) if name.present?
  end

	def institute_name
    institute.try(:name)
  end
  
  def institute_name=(name)
    self.institute = Institute.find_or_create_by(name: name) if name.present?
  end

  def create_lab
  	if self.role == "group_leader"
	  	self.lab = Lab.create(email: self.email, department: self.department, institute: self.institute)
    end
  end
end
