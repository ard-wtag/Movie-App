# frozen_string_literal: true

class Movie < ApplicationRecord
  has_many :genres, dependent: :destroy
  has_many :reviews, dependent: :destroy # If admin removes a movie from the database, reviews related to that movie, will also be removed

  has_one_attached :movie_cover

  validates :title, :director, :synopsis, presence: true
  validates :release_date, presence: true

  scope :sorted_by_title, -> { order(:title) }

  def all_genres
    #
    #         This method will utilize the scope defined in the genre model
    #         to return all the genres associated with the particular movie
    Genre.for_movie(self)
  end



end
