class User < ActiveRecord::Base  
  mount_uploader :icon, IconUploader
  process_in_background :icon

  has_paper_trail

  extend FriendlyId
  friendly_id :slug_candidates, use: [:slugged, :history]

  # Include default devise modules. Others available are:
  # :token_authenticatable, :lockable, and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable, :timeoutable

  belongs_to :institute
  validates_associated  :institute
  validates :institute_name, presence: { message: "You must enter your institute's name", if: :gl? }
  
  belongs_to :department
  validates_associated :department
  # validates_presence_of :department_id, allow_blank: true

  belongs_to :lab
  validates_associated  :lab
  validates :lab, presence: { message: "Your group leader must create an account first" }, unless: :gl?, allow_blank: true
  
  validates :email, presence: true, uniqueness: { message: "That email address has already been registered" }
  
  validates :role, presence: true

  before_create :create_lab, :affiliations, :skip_confirmation!, :skip_confirmation_notification!
  after_create  :first_request
  before_update :update_lab, :affiliations, :transition
  
  ROLES = %w[group_leader lab_manager research_associate postdoctoral_researcher doctoral_candidate 
                    master's_student project_student technician other]

  def should_generate_new_friendly_id?
    first_name_changed? || last_name_changed?  || role_changed?
  end

  def reject
    self.approved = false
    self.lab_id   = nil
    self.institute_id = nil
    self.department_id = nil
    self.joined  = nil
  end

  def approve
    self.approved = true   
    self.joined = Time.now
  end 

  def retire
    self.approved = false
    self.lab_id   = nil
    self.institute_id = nil
    self.department_id = nil
    self.joined  = nil
  end

  def location
    institute.city
  end

  def fullname
    if self.last_name.blank?
      self.email
    else
      "#{first_name} #{last_name}"
    end
  end

  def gl
    User.find(self.lab.users.where(role: "group_leader"))
  end

  def gl?
    self.role == "group_leader"
  end

  def gl_lm?
    self.role == "group_leader" || self.role == "lab_manager"
  end

  def lm?
    self.role == "lab_manager"    
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

  def active_for_authentication?
    super && approved? || lab_id = 1
  end 

  def first_request
    if !self.gl? && !self.confirmed? && !self.approved?
      UserMailer.delay_for(10.seconds).request_email(self.id, self.lab_id)
    end
  end

  def transition
    if !self.gl? && self.lab_id_changed? && self.confirmed?  
      self.approved = false
      self.lab_id   = lab_id
      self.institute_id = nil
      self.department_id = nil
      self.joined  = nil
      UserMailer.delay_for(10.seconds, retry: false).request_email(self.id, self.lab_id)
    end
  end

  def skip_confirmation!
    true

  end

  def inactive_message 
    if !approved? 
      :not_approved
    else
      super # Use whatever other message 
    end 
  end

  def affiliations
    if !gl? && self.approved?
      self.institute_id = lab.institute_id
      self.department_id = lab.department_id
    end
  end

  def create_lab
    if self.gl?
      self.approved = true
      self.joined = Time.now      
      self.send_confirmation_instructions
      self.lab = Lab.create(name: self.email, email: self.email,
                            department: self.department, institute: self.institute)
    end
  end

  def update_lab
    if self.gl? && !self.lab_id_changed?
      if self.institute_id_changed?
        self.department = nil
      end    
      self.lab.update_attributes(name: self.fullname, email: self.email,
                                 department: self.department, institute: self.institute)
    end
  end

  def gl_promotion
    
  end

  private

  def slug_candidates
    [
      :fullname,
      [:fullname, :id]
    ]
  end    
end
