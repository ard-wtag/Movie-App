# frozen_string_literal: true

# spec/factories/users.rb

FactoryBot.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    user_name { Faker::Internet.username(specifier: 5..8) }
    email { Faker::Internet.email }
    phone_number { Faker::PhoneNumber.phone_number }
    password { 'password123' } # Adjust as necessary based on your validations
    password_confirmation { 'password123' }
    role { :user }
  end
end
