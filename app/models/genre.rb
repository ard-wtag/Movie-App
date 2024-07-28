# frozen_string_literal: true

class Genre < ApplicationRecord
  belongs_to :movie
  validates :genre_type, presence: true

  scope :for_movie, lambda { |movie|
                      where(movie: movie).pluck(:genre_type)
                    } # returns the list of genres for a particular movie

    enum genre_type: {
    "Historical fiction" => "0",
    "Fiction narrative" => "1",
    "Speech" => "2",
    "Fairy tale" => "3",
    "Western" => "4",
    "Comic/Graphic Novel" => "5",
    "Fantasy" => "6",
    "Horror" => "7",
    "Mythopoeia" => "8",
    "Fanfiction" => "9",
    "Legend" => "10",
    "Crime/Detective" => "11",
    "Tall tale" => "12",
    "Narrative nonfiction" => "13",
    "Short story" => "14",
    "Essay" => "15"
  }
end


