require 'faker'

FactoryGirl.define do
  factory :institute do
    name			{ Faker::Name.name }
    address		{ Faker::Address.street_address }
    url				{ Faker::Internet.url }
  end
end
