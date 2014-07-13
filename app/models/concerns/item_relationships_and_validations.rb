# Included in Device, Reagent
module ItemRelationshipsAndValidations
	extend ActiveSupport::Concern

	CURRENCIES = %w[$ €]

	included do
	  delegate :gl, to: :lab, allow_nil: true

		acts_as_taggable_on :category
		
		belongs_to :lab, counter_cache: true, touch: true
		validates_associated :lab
		validates_presence_of :lab

	  has_many :ownerships, dependent: :destroy
		has_many :users, through: :ownerships

		validates_length_of :description, maximum: 223
	  validates :product_url, presence: true, url: true, allow_blank: true
	  validates :purchasing_url, presence: true, url: true, allow_blank: true

		validates :name, presence: true
	  validates :currency, inclusion: { in: CURRENCIES }
	  validates :price, 
	  					numericality: { greater_than_or_equal_to: 0, 
	  													message: 'Must be a positive number or 0' }
	  validates :serial, 
	  					unique: false, 
	  					allow_blank: true, 
	  					allow_nil: true
    validates :uid,
    					allow_blank: true, 
    					uniqueness: { scope: [:lab_id, :name], 
    												message: "There is already another item in your lab of this type, name and UID" }
	end
end