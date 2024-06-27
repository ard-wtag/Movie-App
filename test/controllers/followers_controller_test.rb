require "test_helper"

class FollowersControllerTest < ActionDispatch::IntegrationTest
  test "should get followee" do
    get followers_followee_url
    assert_response :success
  end
end
