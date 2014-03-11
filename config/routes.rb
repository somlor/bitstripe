BitStripe::Application.routes.draw do
  root to: "profile#index"
  resources :profile, only: [:index]

  resources :invoices, only: [:index, :show, :create]

  resources :payments, only: [:create]
  get "payments" => "payments#create" # blockchain.info callback is via GET

  resource :session, only: [:new, :create, :destroy]
  get "login" => "sessions#new"
  get "logout" => "sessions#destroy"
end
