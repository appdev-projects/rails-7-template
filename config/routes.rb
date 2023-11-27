Rails.application.routes.draw do
  get '/404', to: 'errors#not_found'
  get '/500', to: 'errors#internal_server_error'
  # resources :listings
  # resources :retailers
  # resources :snapshots
  # resources :products
  
  resources :waitlist_entries, only: [:create]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  root "static#index"

  match '*umatched_route', to: 'errors#not_found', via: :all
end
