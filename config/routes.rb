Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "forecasts#new"

  resources :users, only: [:new, :create, :edit, :update]
  resources :sessions, only: [:new, :create, :destroy]
  resources :forecasts, only: [:new, :create, :show]

  namespace :api do
    namespace :v1 do
      resources :users, only: [:create]
      resources :sessions, only: [:create]
      resource :average_temperature, only: [:show]
    end
  end
end
