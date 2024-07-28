# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FollowList, type: :model do
  context 'validations' do
    it 'is valid with valid attributes' do
      follower = create(:user)
      followee = create(:user)
      follow_list = build(:follow_list, follower: follower, followee: followee)
      expect(follow_list).to be_valid
    end

    it 'is not valid if a user follows themselves' do
      user = create(:user)
      follow_list = build(:follow_list, follower: user, followee: user)
      expect(follow_list).to_not be_valid
    end

    it 'is not valid if a user follows the same user more than once' do
      follower = create(:user)
      followee = create(:user)
      create(:follow_list, follower: follower, followee: followee)
      duplicate_follow_list = build(:follow_list, follower: follower, followee: followee)
      expect(duplicate_follow_list).to_not be_valid
    end
  end

  context 'associations' do
    it { should belong_to(:follower) }
    it { should belong_to(:followee) }
  end
end
