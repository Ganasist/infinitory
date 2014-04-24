# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :blog do
    title "MyString"
    subtitle "MyString"
    entry "MyText"
  end
end
