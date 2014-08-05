class Reagent < ActiveRecord::Base

  # include Amoeba
  include Attachments
  include ItemFullname
  include ItemRelationshipsAndValidations
  include ItemShareAndLocation
  include URLProtocolsAndValidations
  include PgSearch
  include PublicActivity::Common


  validates :remaining, numericality: true, allow_blank: true, inclusion: { in: 0..100, message: 'The amount remaining must be between 0 and 100' }
  
  # validates_date :expiration, after: lambda { Date.today }, after_message: 'Expiration date must be set after today',
  # 														if: Proc.new { |reagent| reagent.expiration_changed? }


  pg_search_scope :pg_search, against: [:name, :uid, :serial, :location, :description],
                              using: { tsearch: { prefix: true, dictionary: 'english' } }

  scope :modified_recently, -> { order("updated_at Desc") }
  scope :expired,           -> { where("expiration < ?", Date.today )}
  
	amoeba do
    enable
    customize(lambda { |original_reagent, new_reagent|
    	new_reagent.uid        = SecureRandom.hex(2)
    	new_reagent.remaining  = 100
    	new_reagent.activities = []
      if original_reagent.expiration? && original_reagent.expiration.past?
        new_reagent.expiration = Date.today + 5.years
      end
      if original_reagent.icon.present?
      	new_reagent.icon = original_reagent.icon
     	end
      if original_reagent.pdf.present?
        new_reagent.pdf = original_reagent.pdf
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
    after_commit :reagent_depletion_worker, on: :update, 
                                            if: Proc.new { |r| r.previous_changes.include?(:remaining) &&
                                                               r.remaining < 21 }
    def reagent_depletion_worker
      ReagentDepletionWorker.perform_async(self.id)
    end

    before_save :set_expiration, on: :update, if: Proc.new { |r| r.expiration.blank? }
    def set_expiration
      self.expiration = Date.today + 5.years
    end

	  def self.text_search(query)
	    if query.present?
	      @reagents = pg_search(query)
	    else
	      scoped
	    end
	  end
end