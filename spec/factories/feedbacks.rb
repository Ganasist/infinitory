# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :feedback do
  	email									{ Faker::Internet.email }
  	comment								{ Faker::Lorem.paragraph }
  	user									"Bob Toner"
  end
end
