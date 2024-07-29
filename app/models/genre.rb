class Genre < ApplicationRecord
  belongs_to :movie
  validates :genre_type, presence: true 
  
  scope :for_movie, -> (movie) { where(movie: movie).pluck(:genre_type) } # returns the list of genres for a particular movie 

end
