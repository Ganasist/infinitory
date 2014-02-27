# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :account do
    braintree_customer_id "MyString"
    billing_start "2014-02-27"
    billing_day 1
    invoice false
    vat_number "MyString"
  end
end
