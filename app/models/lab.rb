class Lab < ActiveRecord::Base
  has_merit

	validates :email, presence: true

	belongs_to :department, counter_cache: true, touch: true
	validates_associated :department
	
	belongs_to :institute, counter_cache: true, touch: true
	validates_associated	:institute
	validates :institute, presence: true

	has_many :users
  has_many :reagents
  has_many :devices

  before_validation :smart_add_url_protocol, if: Proc.new { |l| l.url.present? && l.url_changed? }

  validates :url, :url => { allow_blank: true, message: "Invalid URL, please include http:// or https://" }
  validates :linkedin_url, :url => { allow_blank: true, message: "Invalid URL, please include http:// or https://" }
  validates :xing_url, :url => { allow_blank: true, message: "Invalid URL, please include http:// or https://" }
  validates :twitter_url, :url => { allow_blank: true, message: "Invalid URL, please include http:// or https://" }
  validates :facebook_url, :url => { allow_blank: true, message: "Invalid URL, please include http:// or https://" }
  validates :google_plus_url, :url => { allow_blank: true, message: "Invalid URL, please include http:// or https://" }

  attr_accessor :delete_icon
  attr_reader :icon_remote_url
  before_validation { icon.clear if delete_icon == '1' }
  has_attached_file :icon, styles: { thumb: '50x50>', original: '800x450>' }
  validates_attachment :icon, :size => { :in => 0..2.megabytes, message: 'Picture must be under 2 megabytes in size' }
  validates_attachment_content_type :icon, :content_type => /^image\/(png|gif|jpeg)/, :message => 'only (png/gif/jpeg) images'
  process_in_background :icon

  acts_as_commentable

  # extend FriendlyId
  # friendly_id :slug_candidates, use: [:slugged, :history]

  def icon_remote_url=(url_value)
     if url_value.present?
      self.icon = URI.parse(url_value)
      @icon_remote_url = url_value
    end
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

  def gl
		User.find_by(email: self.email)
    # self.users.where(role: "group_leader").to_a
  end

  def gl_lm
    users.where('role = ? OR role = ?', 'group_leader', 'lab_manager')
  end

	def city
		institute.city
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

	private

    def smart_add_url_protocol
      unless self.url[/^http:\/\//] || self.url[/^https:\/\//]
        self.url = 'http://' + self.url
      end
    end

  	def should_generate_new_friendly_id?
    	name_changed?
    end

    # def slug_candidates
    #   [
    #     :name,
    #     [:name, :city]
    #   ]
    # end
end
