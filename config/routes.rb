Rails.application.routes.draw do
  devise_for :users, controllers: {
    omniauth_callbacks: "omniauth_callbacks"
  }
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
    get 'users/sign_in', to: redirect('/users/auth/line'), as: :new_user_session
  end
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  root 'top_page#index'
  resources :stopwatches, only: %i[update index]
  post '/stopwatches', to: 'stopwatches#create'

  # Defines the root path route ("/")
  # root "posts#index"
end
