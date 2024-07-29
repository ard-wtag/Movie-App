class Review < ApplicationRecord
  belongs_to :movie
  belongs_to :user
  
  has_many :comments, dependent: :destroy # destroying a review will also delete all the comments associated with it

  validates :rating, presence: true, inclusion: { in: 1..10 }
  validates :review, presence: true 

  def all_comments
    comments.map do |comment|
      { user_id: comment.user_id, comment: comment.comment }
    end
  end
 
end
