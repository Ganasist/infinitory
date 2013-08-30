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
    lab.try(:email)
  end
  
  def lab_email=(email)
    self.lab = Lab.find_or_create_by(email: email) if email.present?
  end

  def department_name
    department.try(:name)
  end
  
  def department_name=(name)
    self.department = Department.find_or_create_by(name: name) if name.present?
  end

  def institute_name
    institute.try(:name)
  end
  
  def institute_name=(name)
    self.institute = Institute.find_or_create_by(name: name) if name.present?
  end
end
