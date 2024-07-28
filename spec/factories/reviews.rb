FactoryBot.define do
    factory :review do
      association :movie
      association :user
      rating { rand(1..10) }
      review { Faker::Lorem.sentence }
    end
  end