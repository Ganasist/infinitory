require 'faker'

FactoryGirl.define do
  factory :reagent do
  	lab
  	user
    name        { Faker::Name.name }
    category    { %w[antibody chemical_(powder) chemical_(solution) enzyme kit cell_line].sample }
    location    { "Room:#{Random.new.rand(1..999)}" +  "#{Faker::Address.street_address}" }
  end
end