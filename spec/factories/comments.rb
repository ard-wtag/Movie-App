FactoryBot.define do
    factory :comment do
      association :review
      association :user
      comment { Faker::Lorem.sentence }
    end
  end