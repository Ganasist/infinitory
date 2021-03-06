require 'faker'
require 'securerandom'

FactoryGirl.define do
  factory :device do
    lab
    name                   { Faker::Lorem.word }
    currency               { %w[$ €].sample }
    price                  { Random.rand(100000) }
    serial                 { SecureRandom.hex(Random.rand(2..8)) }
    location               { %w[counter_1 counter_2 fridge_1 fridge_2 fridge_3 freezer_1 freezer_2 freezer_3].sample.humanize }
    uid                    { SecureRandom.hex(2) }
    product_url            { Faker::Internet.url }
    purchasing_url         { Faker::Internet.url }
  end
end