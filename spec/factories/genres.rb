# spec/factories/genres.rb
FactoryBot.define do
  factory :genre do
    association :movie
    genre_type { Genre.genre_types.keys.sample }  # Use a random genre_type from the enum
  end
end
