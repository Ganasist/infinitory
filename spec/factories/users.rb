# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "johndoe#{n}@example.com"}
    role 'group_leader'
    password  'loislane'
    password_confirmation 'loislane'
		# required if the Devise Confirmable module is used
    confirmed_at Time.now
  end
end
