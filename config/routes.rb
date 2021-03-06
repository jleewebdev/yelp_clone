Rails.application.routes.draw do
  get 'ui(/:action)', controller: 'ui'
  
  root "businesses#index"

  get "sign_up", to: "users#new"
  post "sign_up", to: "users#create"

  get "sign_in", to: "sessions#new"
  post "sign_in", to: "sessions#create"

  get "sign_out", to: "sessions#destroy"
  get "reviews/recent", to: "reviews#recent"

  resources :users
  resources :businesses do
    resources :reviews, only: [:create, :destroy]
  end
  resources :categories
  
end
