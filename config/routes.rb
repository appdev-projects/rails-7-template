Rails.application.routes.draw do
  get 'populate', to: 'populate#populate' if Rails.env.production?
  devise_for :employees
  root "testers#index"
  resources :testers
  resources :products
  resources :brands
  resources :departments
  resources :roles
  resources :shops

  get "/makeup" => "testers#makeup", as: :makeup
  get "/skincare" => "testers#skincare", as: :skincare
  get "/hair" => "testers#hair", as: :hair
  get "/fragrance" => "testers#fragrance", as: :fragrance
  get "/manage_testers" => "testers#manage", as: :manage
end
