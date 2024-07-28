# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Genre, type: :model do
  context 'validations' do
    it 'is valid with valid attributes' do
      genre = build(:genre)
      expect(genre).to be_valid
    end

    it { should validate_presence_of(:genre_type) }
  end

  context 'associations' do
    it { should belong_to(:movie) }
  end

  context 'scopes' do
    it 'returns the list of genres for a particular movie' do
      movie = create(:movie)
      create(:genre, movie: movie, genre_type: "12")  # Enum value for 'Tall tale'
      create(:genre, movie: movie, genre_type: "4")   # Enum value for 'Western'

      genre_names = Genre.for_movie(movie)
      expect(genre_names).to match_array(["Tall tale", "Western"])
    end
  end
end
