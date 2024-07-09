# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Review, type: :model do
  context 'validations' do
    it 'is valid with valid attributes' do
      movie = Movie.create(title: 'Example Movie', release_date: Time.zone.today, director: 'Director Name',
                           synopsis: 'Lorem ipsum')
      user = User.create(first_name: 'John', last_name: 'Doe', user_name: 'johndoe', email: 'john.doe@example.com',
                         phone_no: '1234567890', password: 'password')
      review = Review.new(movie: movie, user: user, rating: 5, review: 'Great movie!')
      expect(review).to be_valid
    end

    it 'is not valid without a rating' do
      movie = Movie.create(title: 'Example Movie', release_date: Time.zone.today, director: 'Director Name',
                           synopsis: 'Lorem ipsum')
      user = User.create(first_name: 'John', last_name: 'Doe', user_name: 'johndoe', email: 'john.doe@example.com',
                         phone_no: '1234567890', password: 'password')
      review = Review.new(movie: movie, user: user, review: 'Great movie!')
      expect(review).to_not be_valid
    end

    it 'is not valid without a review text' do
      movie = Movie.create(title: 'Example Movie', release_date: Time.zone.today, director: 'Director Name',
                           synopsis: 'Lorem ipsum')
      user = User.create(first_name: 'John', last_name: 'Doe', user_name: 'johndoe', email: 'john.doe@example.com',
                         phone_no: '1234567890', password: 'password')
      review = Review.new(movie: movie, user: user, rating: 5)
      expect(review).to_not be_valid
    end

    it 'is not valid with a rating outside the range 1 to 10' do
      movie = Movie.create(title: 'Example Movie', release_date: Time.zone.today, director: 'Director Name',
                           synopsis: 'Lorem ipsum')
      user = User.create(first_name: 'John', last_name: 'Doe', user_name: 'johndoe', email: 'john.doe@example.com',
                         phone_no: '1234567890', password: 'password')
      review = Review.new(movie: movie, user: user, rating: 11, review: 'Great movie!')
      expect(review).to_not be_valid
    end
  end

  context 'associations' do
    it 'belongs to a movie' do
      association = Review.reflect_on_association(:movie)
      expect(association.macro).to eq :belongs_to
    end

    it 'belongs to a user' do
      association = Review.reflect_on_association(:user)
      expect(association.macro).to eq :belongs_to
    end

    it 'has many comments' do
      association = Review.reflect_on_association(:comments)
      expect(association.macro).to eq :has_many
    end
  end

  context 'methods' do
    let(:movie) do
      Movie.create(title: 'Example Movie', release_date: Time.zone.today, director: 'Director Name',
                   synopsis: 'Lorem ipsum')
    end
    let(:user) do
      User.create(first_name: 'John', last_name: 'Doe', user_name: 'johndoe', email: 'john.doe@example.com',
                  phone_no: '1234567890', password: 'password')
    end
    let(:review) { Review.create(movie: movie, user: user, rating: 5, review: 'Great movie!') }

    it 'returns all comments with user_id and comment text' do
      comment1 = Comment.create(review: review, user: user, comment: 'I agree!')
      comment2 = Comment.create(review: review, user: user, comment: 'Me too!')
      expect(review.all_comments).to include(
        { user_id: comment1.user_id, comment: comment1.comment },
        { user_id: comment2.user_id, comment: comment2.comment }
      )
    end
  end
end
