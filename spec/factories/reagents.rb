require 'faker'

FactoryGirl.define do
  factory :reagent do
  	lab
    name        { Faker::Name.name }
    contact     { create(:user) }
    category    { %w[antibody chemical enzyme kit solution].sample }
    location    { "Room:#{Random.new.rand(1..999)}" +  "#{Faker::Address.street_address}" }
  end
end