# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :device, :class => 'Devices' do
    name "MyString"
    category "MyString"
    location "MyString"
    serial "MyString"
    lab_id 1
    user_id 1
    url "MyString"
    icon "MyString"
    icon_processing false
    lock_version 1
    uid "MyString"
    description "MyText"
    price "9.99"
  end
end
