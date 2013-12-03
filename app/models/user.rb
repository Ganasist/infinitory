class User < ActiveRecord::Base

  ROLES = %w[group_leader lab_manager research_associate postdoctoral_researcher doctoral_candidate 
                    master's_student project_student technician other]

  devise :database_authenticatable, :registerable, :confirmable, :async,
         :recoverable, :rememberable, :trackable, :validatable, :timeoutable

  belongs_to :institute, counter_cache: true, touch: true
  validates_associated  :institute
  validates :institute_name, presence: { message: "You must enter your institute's name" },
                             allow_blank: true, if: Proc.new{ |f| f.gl? }
  
  belongs_to :department, counter_cache: true, touch: true
  validates_associated :department
  validates_presence_of :department_id, allow_blank: true

  belongs_to :lab, counter_cache: true, touch: true
  validates_associated  :lab
  validates :lab, presence: { message: 'Your group leader must create an account first' },
                    unless: Proc.new{ |f| f.gl? || !f.new_record? }, allow_blank: true

  has_many :ownerships
  has_many :reagents, through: :ownerships
  
  validates :role, presence: true, inclusion: { in: ROLES }

  before_create :gl_signup, :first_request, :skip_confirmation!, :skip_confirmation_notification!
  after_create  :first_request_email
  before_update :update_lab, :change_lab, :affiliations

  mount_uploader :icon, IconUploader
  process_in_background :icon

  has_paper_trail

  include PublicActivity::Common

  extend FriendlyId
  friendly_id :slug_candidates, use: [:slugged, :history]

  scope :all_gls,   -> { where(role: 'group_leader') }
  scope :lm,        -> { where(role:  'lab_manager') }

  def should_generate_new_friendly_id?
    first_name_changed? || last_name_changed?  || role_changed?
  end

  def reject
    self.approved      = false
    self.lab_id        = nil
    self.institute_id  = nil
    self.department_id = nil
    self.joined        = nil
  end

  def approve
    self.approved      = true   
    self.joined        = Time.now
  end 

  def retire
    self.approved      = false
    self.lab_id        = nil
    self.institute_id  = nil
    self.department_id = nil
    self.joined        = nil
  end

  def location
    if self.lab_id?
      institute.city
    end
  end

  def fullname
    if self.first_name.blank? || self.last_name.blank?
      self.email
    else
      "#{first_name} #{last_name}"
    end
  end

  def gl
    unless self.lab_id.blank?
      User.find_by(email: self.lab.email)
    else
      "#{self.fullname} has no group leader"
    end
  end

  def gl?
    role == 'group_leader'
  end

  def gl_lm?
    role == 'group_leader' || self.role == 'lab_manager'
  end

  def lm?
    role == 'lab_manager'    
  end

  def lab_email
    lab.try(:email)
  end

  def lab_email=(email)
    self.lab = Lab.find_by(email: email) if email.present?
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

  def gl_signup
    if self.gl?
      self.approved = true
      self.joined = Time.now      
      self.send_confirmation_instructions
      self.lab = Lab.create(email: self.email,
                            room:  "#{Random.new.rand(1..999)}" + "#{[*('A'..'Z')].sample}",
                            institute: self.institute,
                            department: self.department,
                            name: self.fullname)
    end
  end

  def first_request
    if !self.gl? && !self.confirmed? && !self.approved? && !self.lab.nil?
      self.institute_id   = lab.institute_id
      self.department_id  = lab.department_id
    end
  end

  def first_request_email  
    if !self.gl? && !self.confirmed? && !self.approved? && !self.lab.nil?
      UserMailer.delay_for(1.second, retry: false).request_email(self.id, self.lab_id)
    end
  end

  def change_lab
    if !self.gl? && self.lab_id_changed?
      self.approved = false
      self.lab_id   = lab_id
      self.joined   = nil
      UserMailer.delay_for(1.second, retry: false).request_email(self.id, self.lab_id)
    end
  end

  def affiliations
    if self.confirmed? && self.approved? && !self.lab.nil?
      self.institute  = lab.institute
      self.department = lab.department
    end
  end

  def update_lab
    if self.gl? && self.confirmed?
      if self.institute_id_changed?
        self.department = nil
      end
      unless self.lab_id.blank? 
        self.lab.update(email: self.email, name: self.fullname,
                        department: self.department, institute: self.institute)
      end
    end
  end

  private

  def slug_candidates
    [  :fullname,
      [:fullname, :id] ]
  end    
end
