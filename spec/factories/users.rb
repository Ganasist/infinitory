# Read about factories at https://github.com/thoughtbot/factory_girl

require 'faker'

FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    role 'group_leader'
    password  'loislane'
    password_confirmation 'loislane'
    institute_name 'Fake School'
		# required if the Devise Confirmable module is used
    confirmed_at Time.now
  end
end
