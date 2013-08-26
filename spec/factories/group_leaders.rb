# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :group_leader do
    name "MyString"
    email "MyString"
    admin false
  end
end
