# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    email 'test@pleasework.com'
    password  'loislane'
    password_confirmation 'loislane'
		# required if the Devise Confirmable module is used
    confirmed_at Time.now
  end
end
