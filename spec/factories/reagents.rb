require 'faker'

FactoryGirl.define do
  factory :reagent do
    name        { Faker::Name.name }
    contact     { Faker::Internet.email }
    lab_id      { Random.new.rand(1..100) }
    category    %w[lab_manager research_associate postdoctoral_researcher doctoral_candidate 
                   master's_student project_student technician other].sample
    location    { "Room:#{Random.new.rand(1..999)}" +  "#{Faker::Address.street_address}" }
  end
end