require 'rails_helper'

RSpec.describe Comment, type: :model do
  context 'validations' do
    it 'is valid with valid attributes' do
      movie = Movie.create(title: 'Example Movie', release_date: Date.today, director: 'Director Name', synopsis: 'Lorem ipsum')
      user = User.create(first_name: 'John', last_name: 'Doe', user_name: 'johndoe', email: 'john.doe@example.com', phone_no: '1234567890', password: 'password')
      review = Review.create(movie: movie, user: user, rating: 5, review: 'Great movie!')
      comment = Comment.new(review: review, user: user, comment: 'I agree!')
      expect(comment).to be_valid
    end

    it 'is not valid without a comment text' do
      movie = Movie.create(title: 'Example Movie', release_date: Date.today, director: 'Director Name', synopsis: 'Lorem ipsum')
      user = User.create(first_name: 'John', last_name: 'Doe', user_name: 'johndoe', email: 'john.doe@example.com', phone_no: '1234567890', password: 'password')
      review = Review.create(movie: movie, user: user, rating: 5, review: 'Great movie!')
      comment = Comment.new(review: review, user: user)
      expect(comment).to_not be_valid
    end
  end

  context 'associations' do
    it 'belongs to a review' do
      association = Comment.reflect_on_association(:review)
      expect(association.macro).to eq :belongs_to
    end

    it 'belongs to a user' do
      association = Comment.reflect_on_association(:user)
      expect(association.macro).to eq :belongs_to
    end
  end
end
