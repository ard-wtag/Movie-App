# spec/factories/users.rb
FactoryBot.define do
    factory :user do
      first_name { Faker::Name.first_name }
      last_name { Faker::Name.last_name }
      user_name { Faker::Internet.username }
      email { Faker::Internet.email }
      phone_number { Faker::PhoneNumber.cell_phone }
      password { 'password' }
      password_confirmation { 'password' }
    end
  end
  