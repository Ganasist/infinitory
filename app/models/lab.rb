class Lab < ActiveRecord::Base

  include URLProtocolsAndValidations
  include Attachments

  has_merit
  acts_as_commentable
  
  acts_as_taggable_on :reagent_category, :device_category
  REAGENT_CATEGORIES = ["antibody", "enzyme", "kit", "vector", "cell culture", "chemical solution", "DNA sample", "RNA sample"]
  DEVICE_CATEGORIES = ["centrifuge", "microscope", "FACS", "PCR", "qPCR", "other", "confocal microscope", "-20 Freezer", "-80 Freezer", "Liquid Nitrogen"]
  
	belongs_to :department, counter_cache: true, touch: true
	validates_associated :department
	
	belongs_to :institute, counter_cache: true, touch: true
	validates_associated	:institute
	validates :institute, presence: true

  has_one :account

	has_many :users
  has_many :reagents, dependent: :destroy
  has_many :devices, dependent: :destroy

  has_many :collaborations, dependent: :destroy, inverse_of: :lab
  has_many :collaborators, through: :collaborations

  has_many :inverse_collaborations, class_name: 'Collaboration', foreign_key: 'collaborator_id', dependent: :destroy, inverse_of: :lab
  has_many :inverse_collaborators, through: :inverse_collaborations, source: :lab

  validates :email, presence: true

  before_create :set_default_categories
  def set_default_categories
    self.reagent_category_list.add(REAGENT_CATEGORIES)
    self.device_category_list.add(DEVICE_CATEGORIES)
  end

  after_create :create_account
  def create_account
    Account.create!(lab_id: self.id)
  end

  before_update :reorder_categories
  def reorder_categories
    self.reagent_category_list.sort!
    self.device_category_list.sort!
  end

  before_destroy :remove_comments, unless: Proc.new { |l| l.comments.nil? }
  def remove_comments
    self.comments.destroy_all
  end

  def reagents_category_count(category)
    reagents.where(category: category).count
  end

  def devices_category_count(category)
    devices.where(category: category).count
  end

  def institute_name
  	institute.name
  end

  def cached_total_points
    if self.points?
      Rails.cache.fetch([self.points, "cached_total_points"], expires_in: 1.hour) { self.points }
    end
  end

  def cached_daily_points
    if self.daily_points?
      Rails.cache.fetch([self.daily_points, "cached_daily_scores"], expires_in: 1.day) { self.daily_points }
    end
  end

  def gl
		User.find_by(email: self.email)
  end

  def gl?
    User.find_by(email: self.email)
  end

  def gl_lm
    users.where('role IN (?)', ['group_leader', 'lab_manager'])
  end

	def location
		if self.room.present? && self.department.present?
			"#{self.room} #{department.address}"
		elsif self.room.present? && self.department.blank?
			"#{self.room} #{institute.address}"
		else
			"#{institute.address}"
		end
	end

  # def lab_email
  #   self.try(:email)
  # end

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

  def size
    users.count
  end

end
