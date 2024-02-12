Rails.application.routes.draw do
  devise_for :users, controllers: {
    omniauth_callbacks: 'omniauth_callbacks'
  }
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
    post 'users/sign_in', to: redirect('/users/auth/line')
  end

  # config/routes.rb

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  root 'top_page#index'
  get 'privacy', to: 'top_page#privacy'
  get 'terms', to: 'top_page#terms'

  resources :stopwatches, only: %i[create update index show] do
    post '/stopwatches', to: 'stopwatches#create'
    get 'daily/:date', to: 'stopwatches#daily', as: :daily, on: :collection
    collection do
      get :my_page
    end
  end

  # get :/my_page, on: :collection

  resources :notification_settings, only: %i[index new create edit update destroy]

  # Defines the root path route ("/")
  # root 'posts#index'
end