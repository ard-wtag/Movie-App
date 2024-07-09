# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FollowList, type: :model do
  context 'validations' do
    it 'is valid with valid attributes' do
      follower = User.create(first_name: 'John', last_name: 'Doe', user_name: 'johndoe', email: 'john.doe@example.com',
                             phone_no: '1234567890', password: 'password')
      followee = User.create(first_name: 'Jane', last_name: 'Doe', user_name: 'janedoe', email: 'jane.doe@example.com',
                             phone_no: '0987654321', password: 'password')
      follow_list = FollowList.new(follower: follower, followee: followee)
      expect(follow_list).to be_valid
    end

    it 'is not valid without a follower' do
      followee = User.create(first_name: 'Jane', last_name: 'Doe', user_name: 'janedoe', email: 'jane.doe@example.com',
                             phone_no: '0987654321', password: 'password')
      follow_list = FollowList.new(followee: followee)
      expect(follow_list).to_not be_valid
    end

    it 'is not valid without a followee' do
      follower = User.create(first_name: 'John', last_name: 'Doe', user_name: 'johndoe', email: 'john.doe@example.com',
                             phone_no: '1234567890', password: 'password')
      follow_list = FollowList.new(follower: follower)
      expect(follow_list).to_not be_valid
    end

    it 'is not valid if a user follows the same user more than once' do
      follower = User.create(first_name: 'John', last_name: 'Doe', user_name: 'johndoe', email: 'john.doe@example.com',
                             phone_no: '1234567890', password: 'password')
      followee = User.create(first_name: 'Jane', last_name: 'Doe', user_name: 'janedoe', email: 'jane.doe@example.com',
                             phone_no: '0987654321', password: 'password')
      FollowList.create(follower: follower, followee: followee)
      follow_list = FollowList.new(follower: follower, followee: followee)
      expect(follow_list).to_not be_valid
    end

    it 'is not valid if a user follows themselves' do
      user = User.create(first_name: 'John', last_name: 'Doe', user_name: 'johndoe', email: 'john.doe@example.com',
                         phone_no: '1234567890', password: 'password')
      follow_list = FollowList.new(follower: user, followee: user)
      expect(follow_list).to_not be_valid
    end
  end

  context 'associations' do
    it 'belongs to a follower' do
      association = FollowList.reflect_on_association(:follower)
      expect(association.macro).to eq :belongs_to
    end

    it 'belongs to a followee' do
      association = FollowList.reflect_on_association(:followee)
      expect(association.macro).to eq :belongs_to
    end
  end
end
