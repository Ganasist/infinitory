# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :institute do
    name "MyString"
    description "MyText"
    latitude 1.5
    longitude 1.5
    city "MyString"
    address "MyString"
  end
end
