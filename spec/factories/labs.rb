require 'faker'

FactoryGirl.define do
  factory :lab do
  	room	"#{Random.new.rand(1..999)}" + "#{[*('A'..'Z')].sample}"
    institute Faker::Company.name
    email Faker::Internet.email
  end
end
