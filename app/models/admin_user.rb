class AdminUser < ApplicationRecord

    has_secure_password

    validates :first_name, :last_name, :user_name, :email, :phone_no, presence: true
    validates :email, :user_name, uniqueness: true
    validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
    validates :password, length: { minimum: 6 }, if: -> { new_record? || !password.nil? }
    
end
