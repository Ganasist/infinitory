require 'faker'

FactoryGirl.define do
  factory :reagent do
    name        { Faker::Name.name }
    contact     { create(:user) }
    lab         { create(:lab) }
    category    { %w[antibody chemical enzyme kit solution].sample }
    location    { "Room:#{Random.new.rand(1..999)}" +  "#{Faker::Address.street_address}" }
  end
end