# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Genre, type: :model do
  context 'validations' do
    it 'is valid with valid attributes' do
      movie = Movie.create(title: 'Example Movie', release_date: Time.zone.today, director: 'Director Name',
                           synopsis: 'Lorem ipsum')
      genre = Genre.new(movie: movie, genre_type: 'Action')
      expect(genre).to be_valid
    end

    it 'is not valid without a genre_type' do
      movie = Movie.create(title: 'Example Movie', release_date: Time.zone.today, director: 'Director Name',
                           synopsis: 'Lorem ipsum')
      genre = Genre.new(movie: movie)
      expect(genre).to_not be_valid
    end
  end

  context 'associations' do
    it 'belongs to a movie' do
      association = Genre.reflect_on_association(:movie)
      expect(association.macro).to eq :belongs_to
    end
  end

  context 'scopes' do
    it 'returns the list of genres for a particular movie' do
      movie = Movie.create(title: 'Example Movie', release_date: Time.zone.today, director: 'Director Name',
                           synopsis: 'Lorem ipsum')
      Genre.create(movie: movie, genre_type: 'Action')
      Genre.create(movie: movie, genre_type: 'Comedy')
      expect(Genre.for_movie(movie)).to match_array(%w(Action Comedy))
    end
  end
end
