# frozen_string_literal: true

FactoryBot.define do
  factory :review do
    rating { 5 }
    review { 'This is a sample review.' }
    association :user
    association :movie
    # Add other attributes as needed
  end
end
