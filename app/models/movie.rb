# frozen_string_literal: true

class Movie < ApplicationRecord
  has_many :genres
  has_many :reviews, dependent: :destroy # If admin removes a movie from the database, reviews related to that movie, will also be removed

  validates :title, :director, :synopsis, presence: true
  validates :release_date, presence: true

  def all_genres
    Genre.for_movie(self)
  end

  def all_reviews_with_comments
    reviews.includes(:comments)
  end
end
