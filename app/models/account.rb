class Account < ActiveRecord::Base
	has_many :receipts
  has_many :payment_plans

  before_create :set_billing_start_and_day
  after_create  :set_up_payment_plans

  # [...]

  # Billing days range from 1-28
  def set_billing_start_and_day
    date = Date.today + DEMO_PERIOD
    self.billing_start ||= date
    self.billing_day   ||= [date.day, 28].min
  end

  def set_up_payment_plans
    self.payment_plans = PaymentPlanTemplate.all.map(&:to_plan)
  end
end