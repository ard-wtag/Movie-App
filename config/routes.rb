Rails.application.routes.draw do
  

  

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
