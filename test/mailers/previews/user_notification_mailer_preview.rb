# frozen_string_literal: true

# Preview all emails at http://localhost:3000/rails/mailers/user_notification_mailer
class UserNotificationMailerPreview < ActionMailer::Preview
  # Preview this email at http://localhost:3000/rails/mailers/user_notification_mailer/login_notification
  def login_notification
    UserNotificationMailer.login_notification
  end

  # Preview this email at http://localhost:3000/rails/mailers/user_notification_mailer/signin_notification
  def signin_notification
    UserNotificationMailer.signin_notification
  end

  # Preview this email at http://localhost:3000/rails/mailers/user_notification_mailer/password_reset
  def password_reset
    UserNotificationMailer.password_reset
  end
end
