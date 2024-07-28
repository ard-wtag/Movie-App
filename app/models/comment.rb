# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :review
  belongs_to :user
  
  validates :comment, presence: true
end
