# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  context 'validations' do
    it 'is valid with valid attributes' do
      user = build(:user)
      expect(user).to be_valid
    end

    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
    it { should validate_presence_of(:user_name) }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:phone_number) }

    it 'validates uniqueness of email' do
      create(:user, email: 'jane.doe@example.com')
      user = build(:user, email: 'jane.doe@example.com')
      expect(user).to_not be_valid
    end

    it 'validates uniqueness of user name' do
      create(:user, user_name: 'janedoe')
      user = build(:user, user_name: 'janedoe')
      expect(user).to_not be_valid
    end

    it 'is not valid with an invalid email format' do
      user = build(:user, email: 'invalid_email')
      expect(user).to_not be_valid
    end

    it 'is not valid with a short password' do
      user = build(:user, password: 'short', password_confirmation: 'short')
      expect(user).to_not be_valid
    end
  end

  context 'associations' do
    it { should have_many(:followed_friend_lists) }
    it { should have_many(:followees).through(:followed_friend_lists) }
    it { should have_many(:follower_friend_lists) }
    it { should have_many(:followers).through(:follower_friend_lists) }
    it { should have_many(:reviews) }
    it { should have_many(:comments) }
  end
end
