# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Movie, type: :model do
  context 'validations' do
    it 'is valid with valid attributes' do
      movie = build(:movie)
      expect(movie).to be_valid
    end

    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:release_date) }
    it { should validate_presence_of(:director) }
    it { should validate_presence_of(:synopsis) }
  end

  context 'associations' do
    it { should have_many(:genres) }
    it { should have_many(:reviews) }
  end

  context 'methods' do
    let(:movie) { create(:movie) }

    it 'returns all genres for the movie' do
      genre1 = create(:genre, movie: movie, genre_type: 'Fiction narrative')
      genre2 = create(:genre, movie: movie, genre_type: 'Fantasy')
      expect(movie.genres.pluck(:genre_type)).to include('Fiction narrative', 'Fantasy')
    end
  end
end
