Rails.application.routes.draw do
  devise_for :users, controllers: {
    omniauth_callbacks: 'omniauth_callbacks'
  }
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
    post 'users/sign_in', to: redirect('/users/auth/line')
  end

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

  resources :notification_settings, only: %i[index new create edit update destroy]
end