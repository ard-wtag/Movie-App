FactoryBot.define do
    factory :comment do
      comment { "This is a sample comment." }
      association :user
      association :review
    end
  end
  