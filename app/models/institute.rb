class Institute < ActiveRecord::Base

	include URLProtocolsAndValidations
	include Attachments

  has_merit
  acts_as_commentable

	has_many :departments
	has_many :labs
	has_many :users

	validates :name, uniqueness: { scope: :address, case_sensitive: false, message: "This institute is already registered at that address" },
									 							 if: Proc.new{ |f| f.address? }

  validates :name, presence: true, allow_blank: false

  validates :email, email: true, allow_blank: true, uniqueness: true

	include PgSearch
  pg_search_scope :search, against: [:name, :acronym, :alternate_name, :city],
                  using: { tsearch: { prefix: true,
                  										dictionary: "english" }}


  before_destroy :remove_comments,
  							 unless: Proc.new { |i| i.comments.nil? }
  def remove_comments
    self.comments.destroy_all
  end

	protected
		def acronym_and_name
	    if self.acronym.blank?
	    	"#{name}"
	    else
		    [
	    		"#{acronym}",
	    		["#{acronym}", "#{city}"]
	    	]
	    end
	  end

		def self.global_search(query)
	    if query.present?
	      search(query)
	    else
	      scoped
	    end
	  end
end
