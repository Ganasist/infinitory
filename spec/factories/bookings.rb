# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :booking do
    title "MyString"
    description "MyText"
    start_time "2014-04-04 14:25:54"
    end_time "2014-04-04 14:25:54"
    device_id 1
    user_id 1
  end
end
