# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :lab do
    department_id 1
    institute_id 1
    group_leader "MyString"
    group_leader_email "MyString"
  end
end
