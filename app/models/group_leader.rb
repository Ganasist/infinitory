class GroupLeader < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, 
  			 :trackable, :validatable, :lockable, :timeoutable

  belongs_to :lab
  belongs_to :department
  belongs_to :institute

  
	def lab_email
    lab.try(email: :lab_email)
  end
  
  def lab_email=(lab_email)
    self.lab = Lab.find_or_create_by(email: lab_email) if lab_email.present?
  end

  def department_name
    department.try(name: :department_name)
  end
  
  def department_name=(department_name)
    self.department = Department.find_or_create_by(name: department_name) if department_name.present?
  end

  def institute_name
    institute.try(name: :institute_name)
  end
  
  def institute_name=(institute_name)
    self.institute = Institute.find_or_create_by(name: institute_name) if institute_name.present?
  end
end
