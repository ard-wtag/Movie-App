# frozen_string_literal: true

class Review < ApplicationRecord
  belongs_to :movie
  belongs_to :user
  has_many :comments, dependent: :destroy

  validates :rating, presence: true, inclusion: { in: 1..10 }
  validates :review, presence: true

  def all_comments
    comments.pluck(:user_id, :comment).map do |user_id, comment|
      { user_id: user_id, comment: comment }
    end
  end
end
