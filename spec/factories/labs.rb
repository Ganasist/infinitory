require 'faker'

FactoryGirl.define do
  factory :lab do
    department_id Faker::Company.name
    institute_name Faker::Company.name
    email Faker::Internet.email
  end
end
