# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  context 'validations' do
    it 'is valid with valid attributes' do
      user = User.new(
        first_name: 'John',
        last_name: 'Doe',
        user_name: 'johndoe',
        email: 'john.doe@example.com',
        phone_no: '1234567890',
        password: 'password',
        password_confirmation: 'password',
      )
      expect(user).to be_valid
    end

    it 'is not valid without a first name' do
      user = User.new(first_name: nil)
      expect(user).to_not be_valid
    end

    it 'is not valid without a last name' do
      user = User.new(last_name: nil)
      expect(user).to_not be_valid
    end

    it 'is not valid without a user name' do
      user = User.new(user_name: nil)
      expect(user).to_not be_valid
    end

    it 'is not valid without an email' do
      user = User.new(email: nil)
      expect(user).to_not be_valid
    end

    it 'is not valid without a phone number' do
      user = User.new(phone_no: nil)
      expect(user).to_not be_valid
    end

    it 'is not valid with a duplicate email' do
      User.create(
        first_name: 'Jane',
        last_name: 'Doe',
        user_name: 'janedoe',
        email: 'jane.doe@example.com',
        phone_no: '0987654321',
        password: 'password',
        password_confirmation: 'password',
      )
      user = User.new(email: 'jane.doe@example.com')
      expect(user).to_not be_valid
    end

    it 'is not valid with a duplicate user name' do
      User.create(
        first_name: 'Jane',
        last_name: 'Doe',
        user_name: 'janedoe',
        email: 'jane.doe@example.com',
        phone_no: '0987654321',
        password: 'password',
        password_confirmation: 'password',
      )
      user = User.new(user_name: 'janedoe')
      expect(user).to_not be_valid
    end

    it 'is not valid with an invalid email format' do
      user = User.new(email: 'invalid_email')
      expect(user).to_not be_valid
    end

    it 'is not valid with a short password' do
      user = User.new(password: 'short', password_confirmation: 'short')
      expect(user).to_not be_valid
    end
  end

  context 'associations' do
    it 'has many followed friend lists' do
      association = User.reflect_on_association(:followed_friend_lists)
      expect(association.macro).to eq :has_many
    end

    it 'has many followees' do
      association = User.reflect_on_association(:followees)
      expect(association.macro).to eq :has_many
    end

    it 'has many follower friend lists' do
      association = User.reflect_on_association(:follower_friend_lists)
      expect(association.macro).to eq :has_many
    end

    it 'has many followers' do
      association = User.reflect_on_association(:followers)
      expect(association.macro).to eq :has_many
    end

    it 'has many reviews' do
      association = User.reflect_on_association(:reviews)
      expect(association.macro).to eq :has_many
    end

    it 'has many comments' do
      association = User.reflect_on_association(:comments)
      expect(association.macro).to eq :has_many
    end
  end
end
