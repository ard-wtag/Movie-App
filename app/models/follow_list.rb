class FollowList < ApplicationRecord
  belongs_to :follower, class_name: 'User' # This sets up a many-to-one relationship where the follower is a User.
  belongs_to :followee, class_name: 'User' # This sets up a many-to-one relationship where the followee is a User.

  validates :follower_id, uniqueness: { scope: :followee_id } # Ensures that a user cannot follow the same user more than once.
  validate :cannot_follow_self # Ensures that a user cannot follow themselves

  private

  def cannot_follow_self
    errors.add(:follower_id, "can't follow yourself") if follower_id == followee_id
  end
end
