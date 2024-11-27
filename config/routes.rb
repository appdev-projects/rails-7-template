Rails.application.routes.draw do
  authenticate :employee, ->(employee) { employee.admin? } do
    mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  end
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
