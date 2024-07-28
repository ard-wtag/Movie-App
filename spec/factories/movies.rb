# spec/factories/movies.rb
FactoryBot.define do
    factory :movie do
      title { Faker::Movie.title }
      release_date { Faker::Date.backward(days: 365) }
      director { Faker::Name.name }
      synopsis { Faker::Lorem.paragraph }
    end
  end
  