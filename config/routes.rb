Rails.application.routes.draw do
  root "users#index"

  devise_for :users, controllers: { registrations: 'user/registrations' }

  resources :survey_responses
  resources :surveys
  resources :reviews

  get "/:id" => "users#show", as: :user
end
