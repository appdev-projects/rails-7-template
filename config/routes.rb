Rails.application.routes.draw do
  get '/404', to: 'erros#not_found'
  get '/500', to: 'erros#internal_server_error'
  # resources :listings
  # resources :retailers
  # resources :snapshots
  # resources :products
  
  resources :waitlist_entries, only: [:create]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  root "static#index"
end
