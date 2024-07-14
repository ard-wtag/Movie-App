require "test_helper"

class UserNotificationMailerTest < ActionMailer::TestCase
  test "login_notification" do
    mail = UserNotificationMailer.login_notification
    assert_equal "Login notification", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

  test "signin_notification" do
    mail = UserNotificationMailer.signin_notification
    assert_equal "Signin notification", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

  test "password_reset" do
    mail = UserNotificationMailer.password_reset
    assert_equal "Password reset", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
