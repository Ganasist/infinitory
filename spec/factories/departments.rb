require 'faker'

FactoryGirl.define do
  factory :department do
  	room	"#{Random.new.rand(1..999)}" + "#{[*('A'..'Z')].sample}"
  	name 			Faker::Company.name
    institute Faker::Company.name
  end
end
