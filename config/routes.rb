Rails.application.routes.draw do
  root "home#index"

  devise_for :users

  resources :survey_responses
  resources :surveys
  resources :reviews
  resources :users, only: :show

  get "/users/:id" => "users#show", as: :user
end
