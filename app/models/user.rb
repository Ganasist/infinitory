class User < ActiveRecord::Base
  has_merit

  ROLES = %w[group_leader lab_manager research_associate postdoctoral_researcher doctoral_candidate 
                    master's_student project_student technician other]

  devise :invitable, :database_authenticatable, :registerable,
         :confirmable, :async, :recoverable, :rememberable,
         :trackable, :validatable, :timeoutable

  belongs_to :institute, counter_cache: true, touch: true
  validates_associated  :institute
  validates :institute_name, presence: { message: "You must enter your institute's name" },
                             allow_blank: true, if: Proc.new{ |f| f.gl? }
  
  belongs_to :department, counter_cache: true, touch: true
  validates_associated :department
  validates_presence_of :department_id, allow_blank: true

  belongs_to :lab, counter_cache: true, touch: true
  validates_associated :lab
  validates :lab, presence: { message: 'Your group leader must create an account first' },
                    unless: Proc.new{ |f| f.gl? || !f.new_record? }, allow_blank: true

  has_many :ownerships
  has_many :reagents, through: :ownerships
  has_many :devices, through: :ownerships
  
  validates :role, presence: true, inclusion: { in: ROLES }

  before_create :skip_confirmation!, :skip_confirmation_notification!
  before_create :gl_signup, if: Proc.new { |f| f.gl? }  
  before_create :first_request, if: Proc.new { |f| !f.gl? && !f.confirmed? && !f.approved? && !f.lab.nil? }
  
  after_create  :first_request_email, if: Proc.new { |f| !f.gl? && !f.confirmed? && !f.approved? && !f.lab.nil? }
  
  before_update :switch_labs
  
  after_update  :update_lab_affiliations, if: Proc.new { |f| f.gl? && f.confirmed? && f.lab.present? }
  
  after_invitation_accepted :gl_invited, if: Proc.new { |f| f.gl? }
  after_invitation_accepted :approve_user, if: Proc.new { |f| !f.gl? }

  mount_uploader :icon, IconUploader
  process_in_background :icon

  has_paper_trail

  acts_as_commentable

  include PublicActivity::Common

  extend FriendlyId
  friendly_id :slug_candidates, use: [:slugged, :history]

  scope :all_gls, -> { where(role: 'group_leader') }
  scope :lm,      -> { where(role:  'lab_manager') }

  def relative_reagents_percentage(category)
    self.reagents.where(category: category).length
  end

  def relative_devices_percentage(category)
    self.devices.where(category: category).length
  end

  def device_count
    self.devices.length
  end

  def reagent_count
    self.reagents.length
  end

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

  # def approve
  #   self.approved      = true
  # end 

  def retire
    self.approved      = false
    self.lab_id        = nil
    self.institute_id  = nil
    self.department_id = nil
    self.joined        = nil
  end

  def retire_permissions?(user, lab)
    self.gl_lm? && (self.lab = lab) && !user.gl? && user != self
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
    role == 'group_leader' || role == 'lab_manager'
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

  def send_reset_password_instructions
    super if invitation_token.nil?
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

  def first_request
    self.institute_id   = lab.institute_id
    self.department_id  = lab.department_id
  end

  def first_request_email
    UserMailer.delay_for(1.second, retry: false).request_email(self.id, self.lab_id)
  end

  def gl_signup
    self.approved = true
    self.joined = Time.now      
    self.send_confirmation_instructions
    self.lab = Lab.create(email: self.email,
                          institute: self.institute,
                          department: self.department)
  end

  def gl_invited
    self.approved = true
    self.joined   = Time.now
    self.lab      = Lab.create(email: self.email,
                               institute: self.institute)
    self.create_activity :gl_invitation, owner: self.invited_by
    self.invited_by.add_points(25)
  end

  def approve_user
    self.approved = true if invited_by_id == self.gl.id
    if self.approved?
      self.joined     = Time.now
      self.institute  = lab.institute
      self.department = lab.department
      self.create_activity :invitation, owner: self.invited_by
      self.invited_by.add_points(10)
    end
  end

  def update_lab_affiliations
    if email_changed?
      self.lab.update(email: self.email)
    end
    if institute_id_changed?
      self.lab.update(institute: self.institute,
                      department: nil)
      self.lab.users.update_all(institute_id: self.institute_id,
                                department_id: nil)
    elsif department_id_changed?
      self.lab.update(department: self.department)
      self.lab.users.update_all(department_id: self.department_id)    
    end
  end

  def switch_labs
    if !self.gl? && self.lab_id? && self.lab_id_changed? && invited_by_id != self.gl.id
      self.approved = false
      self.lab_id   = lab_id
      self.joined   = nil
      UserMailer.delay_for(1.second, retry: false).request_email(self.id, self.lab_id)
    end
  end

  private

  def slug_candidates
    [  :fullname,
      [:fullname, :id] ]
  end    
end
