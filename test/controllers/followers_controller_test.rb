# frozen_string_literal: true

require 'test_helper'

class FollowersControllerTest < ActionDispatch::IntegrationTest
  test 'should get follow' do
    get followers_follow_url
    assert_response :success
  end

  test 'should get unfollow' do
    get followers_unfollow_url
    assert_response :success
  end

  test 'should get followerlist' do
    get followers_followerlist_url
    assert_response :success
  end

  test 'should get followeelist' do
    get followers_followeelist_url
    assert_response :success
  end
end
