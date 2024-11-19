Rails.application.routes.draw do
  root "home#index"

  devise_for :users

  resources :survey_responses
  resources :surveys
  resources :reviews

  get "/:username" => "users#show", as: :user
end
