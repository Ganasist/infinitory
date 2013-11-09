require 'faker'

FactoryGirl.define do
  factory :user do
    email                 { Faker::Internet.email }
    role                   'technician'
    password               'loislane'
    password_confirmation  'loislane'
    confirmed_at Time.now  # required if the Devise Confirmable module is used

    factory :admin do
      role 'group_leader'
      institute_name      { Faker::Name.name }
    end
  end
end
