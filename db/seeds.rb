require 'faker'

# Create 20 Users
20.times do
  User.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    user_name: Faker::Internet.username,
    email: Faker::Internet.email,
    phone_number: Faker::PhoneNumber.cell_phone_in_e164,
    password: '121212',
    password_confirmation: '121212'
  )
end

# Create 20 Movies
20.times do
  Movie.create!(
    title: Faker::Movie.title,
    release_date: Faker::Date.between(from: 50.years.ago, to: Date.today),
    director: Faker::Name.name,
    synopsis: Faker::Lorem.paragraph(sentence_count: 3)
  )
end

# Create 20 Genres
movies = Movie.all
20.times do
  Genre.create!(
    movie: movies.sample,
    genre_type: Faker::Book.genre
  )
end

# Create 20 Reviews
users = User.all
20.times do
  Review.create!(
    movie: movies.sample,
    user: users.sample,
    rating: rand(1..10),
    review: Faker::Lorem.paragraph(sentence_count: 5)
  )
end

# Create 20 Comments
reviews = Review.all
20.times do
  Comment.create!(
    review: reviews.sample,
    user: users.sample,
    comment: Faker::Lorem.paragraph(sentence_count: 2)
  )
end

# Create 20 Follow Lists
20.times do
  follower = users.sample
  followee = users.sample
  unless follower == followee || FollowList.exists?(follower: follower, followee: followee)
    FollowList.create!(
      follower: follower,
      followee: followee
    )
  end
end

puts "Seed data created successfully!"