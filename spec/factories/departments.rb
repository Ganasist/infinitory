# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :department do
    name "MyString"
    institute_id 1
    address "MyString"
    longitude 1.5
    latitude 1.5
  end
end
