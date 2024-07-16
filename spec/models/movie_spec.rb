# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Movie, type: :model do
  context 'validations' do
    it 'is valid with valid attributes' do
      movie = Movie.new(
        title: 'Example Movie',
        release_date: Time.zone.today,
        director: 'Director Name',
        synopsis: 'Lorem ipsum',
      )
      expect(movie).to be_valid
    end

    it 'is not valid without a title' do
      movie = Movie.new(
        release_date: Time.zone.today,
        director: 'Director Name',
        synopsis: 'Lorem ipsum',
      )
      expect(movie).to_not be_valid
    end

    it 'is not valid without a release date' do
      movie = Movie.new(
        title: 'Example Movie',
        director: 'Director Name',
        synopsis: 'Lorem ipsum',
      )
      expect(movie).to_not be_valid
    end

    it 'is not valid without a director' do
      movie = Movie.new(
        title: 'Example Movie',
        release_date: Time.zone.today,
        synopsis: 'Lorem ipsum',
      )
      expect(movie).to_not be_valid
    end

    it 'is not valid without a synopsis' do
      movie = Movie.new(
        title: 'Example Movie',
        release_date: Time.zone.today,
        director: 'Director Name',
      )
      expect(movie).to_not be_valid
    end
  end

  context 'associations' do
    it 'has many genres' do
      association = Movie.reflect_on_association(:genres)
      expect(association.macro).to eq :has_many
    end

    it 'has many reviews' do
      association = Movie.reflect_on_association(:reviews)
      expect(association.macro).to eq :has_many
    end
  end

  context 'methods' do
    let(:movie) do
      Movie.create(title: 'Example Movie', release_date: Time.zone.today, director: 'Director Name',
                   synopsis: 'Lorem ipsum')
    end

    it 'returns all genres for the movie' do
      movie = Movie.create(title: 'Example Movie', release_date: Time.zone.today, director: 'Director Name',
                           synopsis: 'Lorem ipsum')
      genre1 = Genre.create(movie: movie, genre_type: 'Action')
      genre2 = Genre.create(movie: movie, genre_type: 'Drama')
      expect(movie.all_genres).to include(genre1.genre_type, genre2.genre_type)
    end

    it 'returns all reviews with comments' do
      movie = Movie.create(title: 'Example Movie', release_date: Time.zone.today, director: 'Director Name',
                           synopsis: 'Lorem ipsum')
      user = User.create(first_name: 'John', last_name: 'Doe', user_name: 'johndoe', email: 'john.doe@example.com',
                         phone_no: '1234567890', password: 'password')
      review = Review.create(movie: movie, user: user, rating: 5, review: 'Great movie!')
      Comment.create(review: review, user: user, comment: 'Nice review!')
      expect(movie.all_reviews_with_comments).to include(review)
    end
  end
end
