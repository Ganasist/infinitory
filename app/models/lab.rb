class Lab < ActiveRecord::Base

  include URLProtocols
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
  validates :url,
            :twitter_url,
            :facebook_url,
            url: { allow_blank: true, message: "Invalid URL, please include http:// or https://" }

  # attr_accessor :delete_icon
  # attr_reader :icon_remote_url
  # before_validation { icon.clear if delete_icon == '1' }
  # has_attached_file :icon, styles: { thumb: '50x50>', original: '800x450>' }
  # validates_attachment :icon, :size => { :in => 0..2.megabytes, message: 'Picture must be under 2 megabytes in size' }
  # validates_attachment_content_type :icon, :content_type => /^image\/(png|gif|jpeg)/, :message => 'only (png/gif/jpeg) images'
  # process_in_background :icon

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

  # def icon_remote_url=(url_value)
  #    if url_value.present?
  #     self.icon = URI.parse(url_value)
  #     @icon_remote_url = url_value
  #   end
  # end

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
    Rails.cache.fetch([self.points, "cached_total_points"], expires_in: 1.hour) { self.points }
  end

  def cached_daily_points
    Rails.cache.fetch([self.daily_points, "cached_daily_scores"], expires_in: 1.day) { self.daily_points }
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
