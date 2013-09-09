class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :lockable, and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable, :timeoutable

  belongs_to :institute
  belongs_to :department
  belongs_to :lab

  validates_presence_of :lab, message: "Your group leader must create an account first", unless: :gl?
  validates_presence_of :institute_name, message: "You must enter your institute's name", if: :gl?
  validates_uniqueness_of :email
  validates_presence_of :role

  before_validation :create_lab
  after_update      :update_lab
  before_create     :affiliations
  after_save        :set_lab_name
  
  ROLES = %w[group_leader lab_manager lab_member]
  DESCRIPTIONS = %w[research_associate postdoctoral_researcher doctoral_candidate master's_student project_student technician other]

  # def authorize
  #   self.approved = true
  # end

  def active_for_authentication? 
    super && approved? 
  end 

  def inactive_message 
    if !approved? 
      :not_approved 
    else 
      super # Use whatever other message 
    end 
  end

  def fullname
    "#{first_name} #{last_name}"
  end

  def set_lab_name
    if self.gl?
      if !self.fullname.blank?
        self.lab.update_attributes(name: "#{self.fullname}")
      else
        self.lab.update_attributes(name: "#{self.email}")
      end
    end
  end

  def affiliations
    if self.gl?
      self.institute_id = lab.institute_id
      self.department_id = lab.department_id
      self.approved = true
    end
  end

  def gl?
    self.role == "group_leader"
  end

  def gl_lm?
    self.role == "group_leader" || self.role == "lab_manager"
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
  	if self.gl?
	  	self.lab = Lab.create(email: self.email, department: self.department, institute: self.institute)
    end
  end

  def update_lab
    if self.gl?
      @lab = Lab.where(email: self.email)
      @lab.update_all(email: self.email, department_id: self.department_id, institute_id: self.institute_id)
    end
  end
end
