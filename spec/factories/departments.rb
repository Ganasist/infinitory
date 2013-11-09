require 'faker'

FactoryGirl.define do
  factory :department do
  	name 				{ Faker::Company.name }
    institute 	{ Institute.create!(name: 		Faker::Company.name,
	    															address:  Faker::Address.street_address,
	    															url:			Faker::Internet.url) }
    
  end
end
