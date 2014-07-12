class Account < ActiveRecord::Base
	belongs_to :lab
	has_many 	 :receipts
	
	attr_accessor :first_name, :last_name, :cc_number, :cc_exp_month, :cc_exp_year, :cvv

	before_create :set_billing_start_and_day
	TRIAL_PERIOD = 3.months


	def set_billing_start_and_day
		date = Date.today + TRIAL_PERIOD
		self.billing_start ||= date
		self.billing_day   ||= [date.day, 28].min	
	end


end
