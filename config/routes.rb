# frozen_string_literal: true

Rails.application.routes.draw do
  # get 'password_resets/new'
  # get 'password_resets/create'
  # get 'password_resets/edit'
  # get 'password_resets/update'

  root 'movies#index'

  resources :admin_users do
    collection do
      get :login
      post :attempt_login
      delete :logout
    end
  end

  resources :comments do
    member do
      get :delete
    end
  end

  resources :followers do
    member do
      get :followerlist
      get :followeelist
      post :follow
      delete :unfollow
    end
  end

  resources :movies do
    member do
      get :delete
    end
    resources :reviews, only: %i[new create index show]
  end

  resource :password_reset, only: [:new, :create, :edit, :update]

  resources :reviews do
    member do
      get :delete
    end
    resources :comments, only: %i[destroy create]
  end

  resources :users do
    member do
      get :delete
    end
    collection do
      get :login
      post :attempt_login
      delete :logout
    end
  end

  get 'up' => 'rails/health#show', as: :rails_health_check
end
