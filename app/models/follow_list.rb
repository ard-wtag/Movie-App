# frozen_string_literal: true

class FollowList < ApplicationRecord
  belongs_to :follower, class_name: 'User'
  belongs_to :followee, class_name: 'User'

  validates :follower_id, uniqueness: { scope: :followee_id }
  validate :cannot_follow_self

  private

  def cannot_follow_self
    errors.add(:follower_id, I18n.t('errors.messages.cannot_follow_self')) if follower_id == followee_id
  end
end
