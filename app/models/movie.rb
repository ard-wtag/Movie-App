class Movie < ApplicationRecord

    has_many :genres, dependent: :destroy  
    has_many :reviews, dependent: :destroy #If admin removes a movie from the database, reviews related to that movie, will also be removed

    validates :title, :director, :synopsis, presence: true
    validates :release_date, presence: true

    scope :sorted_by_title, -> { order(:title) } 

    def all_genres 
=begin 
        This method will utilize the scope defined in the genre model
        to return all the genres associated with the particular movie 
=end
        Genre.for_movie(self)
    end

    def all_reviews_with_comments
        reviews.includes(:comments)
    end

    
    
end
