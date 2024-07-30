# frozen_string_literal: true

# spec/controllers/password_resets_controller_spec.rb

require 'rails_helper'

RSpec.describe PasswordResetsController, type: :controller do
  let(:user) { FactoryBot.create(:user) }

  describe 'GET #new' do
    it 'renders the new template' do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe 'POST #create' do
    context 'when email is found' do
      it 'sends a password reset email' do
        allow(UserNotificationMailer).to receive_message_chain(:with, :password_reset, :deliver_now)

        post :create, params: { email: user.email }

        expect(UserNotificationMailer).to have_received(:with).with(user: user)
        expect(response).to redirect_to(login_users_path)
        expect(flash[:notice]).to eq('If an account with that email was found, we have sent a link to reset password')
      end
    end

    context 'when email is not found' do
      it 'redirects to login with notice' do
        post :create, params: { email: 'nonexistent@example.com' }

        expect(response).to redirect_to(login_users_path)
        expect(flash[:notice]).to eq('If an account with that email was found, we have sent a link to reset password')
      end
    end
  end

  describe 'GET #edit' do
    context 'when token is valid' do
      it 'renders the edit template' do
        token = user.signed_id(purpose: 'password_reset', expires_in: 15.minutes)

        get :edit, params: { token: token }

        expect(response).to render_template(:edit)
        expect(assigns(:user)).to eq(user)
      end
    end

    context 'when token is invalid' do
      it 'redirects to login with alert' do
        get :edit, params: { token: 'invalid' }

        expect(response).to redirect_to(login_users_path)
        expect(flash[:alert]).to eq('Your token has expired. Please try again')
      end
    end
  end

  describe 'PATCH #update' do
    context 'when token is valid' do
      it 'updates the user password and redirects to login' do
        token = user.signed_id(purpose: 'password_reset', expires_in: 15.minutes)
        patch :update, params: { token: token, user: { password: 'newpassword', password_confirmation: 'newpassword' } }

        expect(response).to redirect_to(login_users_path)
        expect(flash[:notice]).to eq('Your password was reset successfully. Please sign in.')
      end

      it 'renders edit when passwords do not match' do
        token = user.signed_id(purpose: 'password_reset', expires_in: 15.minutes)
        patch :update,
              params: { token: token, user: { password: 'newpassword', password_confirmation: 'wrongpassword' } }

        expect(response).to render_template(:edit)
      end
    end

    context 'when token is invalid' do
      it 'redirects to login with alert' do
        patch :update,
              params: { token: 'invalid', user: { password: 'newpassword', password_confirmation: 'newpassword' } }

        expect(response).to redirect_to(login_users_path)
        expect(flash[:alert]).to eq('Your token has expired. Please try again')
      end
    end
  end
end
