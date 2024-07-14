class UserNotificationMailer < ApplicationMailer
  default from: 'no-reply@example.com'

  def login_notification(user)
    @greeting = "Hi"
    @user=user 

    mail(to: @user.email, subject: 'Successfully Loggedin')

    
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_notification_mailer.signin_notification.subject
  #
  def signin_notification(user)
    @greeting = "Hi"
    @user=user 

    mail(to: @user.email, subject: 'Successfully Loggedin')
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_notification_mailer.password_reset.subject
  #
  def password_reset
    @greeting = "Hi"

    mail to: "to@example.org"
  end
end
