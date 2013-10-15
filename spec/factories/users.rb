# Read about factories at https://github.com/thoughtbot/factory_girl

require 'faker'

FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    role 'technician'
    password  'loislane'
    password_confirmation 'loislane'
  	# required if the Devise Confirmable module is used
    confirmed_at Time.now

    factory :admin do
      role 'group_leader'
      institute_name 'Bigtime Institute'
    end
  end
end
