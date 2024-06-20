Rails.application.routes.draw do
  root 'admin_users#index'
  
  get 'admin_login', to: 'admin_users#login'
  post 'admin_attempt_login', to: 'admin_users#attempt_login'

  resources :admin_users do
    member do 
      get :confirm_movie_delete
      delete :confirm_movie_destroy 

      get :confirm_user_delete
      delete :confirm_user_destroy  
      get :show_user_details
    end 

    collection do
      get :movielist
      get :userlist
      post :create
      get :new

      delete :logout   # doesnt work with delete  # will work if i use button_to instead of link_to in the view
    end
  end 

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
