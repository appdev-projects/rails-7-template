Rails.application.routes.draw do
  devise_for :employees
  root "testers#index"
  resources :testers
  resources :products
  resources :brands
  resources :departments
  resources :stores
  resources :roles
end
