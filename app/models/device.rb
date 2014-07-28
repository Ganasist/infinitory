class Device < ActiveRecord::Base
  
  # include Amoeba
  include Attachments
  include ItemFullname
  include ItemRelationshipsAndValidations
  include ItemShareAndLocation
  include URLProtocolsAndValidations
  include PgSearch
  include PublicActivity::Common

  has_many :bookings
  has_many :user_bookings, through: :bookings, class_name: 'User', foreign_key: 'user_id', source: :user
  
  pg_search_scope :pg_search, against: [:name, :uid, :serial, :location, :description],
                   				 		using: { tsearch: { prefix: true, dictionary: 'english' } }

	scope :modified_recently, -> { order("updated_at DESC") }
  
  amoeba do
    enable
    customize(lambda { |original_device, new_device|
      new_device.uid        = SecureRandom.hex(2)
      new_device.activities = []
      new_device.bookings   = []
      if original_device.icon.present?
        new_device.icon = original_device.icon
      end
      if original_device.pdf.present?
        new_device.pdf = original_device.pdf
      end
    })
  end

  def fullname_without_location
    if self.uid.present?
        "#{self.name}-#{self.uid}"
    elsif !self.uid.present?
      "#{self.name}"
    end
  end

  private
    after_commit :online_status_worker, on: :update, if: Proc.new { |d| d.previous_changes.include?(:status) }
    def online_status_worker
      OnlineStatusWorker.perform_async(self.id)    
    end

    after_commit :bookable_status_worker, on: :update, if: Proc.new { |d| d.previous_changes.include?(:bookable) }
    def bookable_status_worker
      BookableStatusWorker.perform_async(self.id)    
    end

	  def self.text_search(query)
	    if query.present?
	      @devices = pg_search(query)
	    else
	      scoped
	    end
	  end
end