Rails.application.routes.draw do

  root 'admin_users#index'
  
  resources :admin_users do
    collection do
      get :login
      post :attempt_login
      delete :logout 
    end
  end 

  resources :movies  do 
    member do
      get :delete  
    end
  end 

  resources :users do 
    member do
      get :delete  
    end 
  end 

  get "up" => "rails/health#show", as: :rails_health_check

end
