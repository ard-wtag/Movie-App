Rails.application.routes.draw do
  get 'followers/follow'
  get 'followers/unfollow'
  get 'followers/followerlist'
  get 'followers/followeelist'
  

  

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

  resources :movies  do 
    member do
      get :delete  
    end
    resources :reviews, only: [:new,:create,:index,:show] 
  end 

  resources :reviews  do 
    member do
      get :delete  
    end
    resources :comments, only: [:destroy, :create]
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

  get "up" => "rails/health#show", as: :rails_health_check


end
