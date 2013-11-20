require 'faker'

FactoryGirl.define do
  factory :reagent do
  	lab
  	user
    name        Faker::Name.name
    category    %w[antibody cell_culture cell_line chemical_(powder) chemical_(solution) enzyme kit].sample
    price				Random.rand(1000)
    location    "Room:#{Random.new.rand(1..999)}" +  "#{Faker::Address.street_address}"
  end
end