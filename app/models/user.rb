# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password
  enum role: { user: 0, admin: 1 }

  # A user follows many users through the FollowList join model
  has_many :followed_friend_lists, foreign_key: :follower_id, class_name: 'FollowList' , dependent: :destroy # A list of pepople i follow 
  has_many :followees, through: :followed_friend_lists, source: :followee , dependent: :destroy

  # A user is followed by many users through the FollowList join model
  has_many :follower_friend_lists, foreign_key: :followee_id, class_name: 'FollowList' , dependent: :destroy # A list of people that follow me
  has_many :followers, through: :follower_friend_lists, source: :follower , dependent: :destroy

  has_many :reviews, dependent: :destroy # if the user is removed, so will all of his/her reviews
  has_many :comments, dependent: :destroy # if the user is removed, so will all of his/her comments

  has_one_attached :profile_picture

  validates :first_name, :last_name, :user_name, :email, :phone_no, presence: true
  validates :email, :user_name, uniqueness: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, length: { minimum: 6 }, if: -> { new_record? || !password.nil? }

  def full_name
    "#{first_name} #{last_name}"
  end
end
