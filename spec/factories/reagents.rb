require 'faker'
require 'securerandom'

FactoryGirl.define do
  factory :reagent do
  	lab
    name        { Faker::Lorem.word }
    currency    { %w[$ €].sample }
    price				{ Random.rand(1000) }
    serial			{ SecureRandom.hex(Random.rand(2..8)) }
    remaining		{ Random.rand(100) }
    expiration  { Date.today+(1000*rand()) }
    location    { %w[counter_1 counter_2 fridge_1 fridge_2 fridge_3 freezer_1 freezer_2 freezer_3].sample.humanize }
  	uid         { SecureRandom.hex(2) }
    product_url            { Faker::Internet.url }
    purchasing_url         { Faker::Internet.url }
  end
end