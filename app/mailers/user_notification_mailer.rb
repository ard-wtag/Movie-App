# frozen_string_literal: true

class UserNotificationMailer < ApplicationMailer
  default from: 'no-reply@example.com'

  def login_notification(user)
    @greeting = 'Hi'
    @user = user

    mail(to: @user.email, subject: 'Successfully Logged in')
  end

  def signin_notification(user)
    @greeting = 'Hi'
    @user = user

    mail(to: @user.email, subject: 'Successfully Loggedin')
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_notification_mailer.password_reset.subject
  #
  def password_reset
    @user = params[:user]
    @token = @user.signed_id(purpose: 'password_reset', expires_in: 15.minutes)
    mail to: @user.email, subject: 'Password Reset Instructions'
  end
end
