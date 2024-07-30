# frozen_string_literal: true

# spec/controllers/followers_controller_spec.rb

require 'rails_helper'

RSpec.describe FollowersController, type: :controller do
  let(:user) { FactoryBot.create(:user) }
  let(:other_user) { FactoryBot.create(:user) }
  let(:origin_user) { FactoryBot.create(:user) }

  before do
    session[:user_id] = user.id
  end

  describe 'POST #follow' do
    it 'follows the user' do
      expect do
        post :follow, params: { id: other_user.id, origin_user: origin_user.id, origin_view: 'user' }
      end.to change(FollowList, :count).by(1)
    end

    it 'redirects to the correct origin view' do
      post :follow, params: { id: other_user.id, origin_user: origin_user.id, origin_view: 'user' }
      expect(response).to redirect_to(user_path(origin_user))
    end
  end

  describe 'DELETE #unfollow' do
    before do
      FactoryBot.create(:follow_list, follower: user, followee: other_user)
    end

    it 'unfollows the user' do
      expect do
        delete :unfollow, params: { id: other_user.id, origin_user: origin_user.id, origin_view: 'user' }
      end.to change(FollowList, :count).by(-1)
    end

    it 'redirects to the correct origin view' do
      delete :unfollow, params: { id: other_user.id, origin_user: origin_user.id, origin_view: 'user' }
      expect(response).to redirect_to(user_path(origin_user))
    end
  end

  describe 'GET #followerlist' do
    it 'assigns the followers to @followers' do
      get :followerlist, params: { id: user.id }
      expect(assigns(:followers)).to eq(user.followers)
    end
  end

  describe 'GET #followeelist' do
    it 'assigns the followees to @followees' do
      get :followeelist, params: { id: user.id }
      expect(assigns(:followees)).to eq(user.followees)
    end
  end
end
