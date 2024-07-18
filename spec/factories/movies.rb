# spec/factories/movies.rb

FactoryBot.define do
    factory :movie do
      title { Faker::Movie.title }
      release_date { Faker::Date.between(from: 10.years.ago, to: Date.today) }
      director { Faker::Name.name }
      synopsis { Faker::Lorem.paragraph }
    end
  end
  