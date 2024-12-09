Rails.application.routes.draw do
  authenticate :employee, ->(employee) { employee.admin? } do
    mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  end
  devise_for :employees, sign_out_via: :delete
  root "testers#welcome"
  resources :testers
  resources :products
  resources :brands
  resources :departments
  resources :roles
  resources :shops

  get "/welcome" => "testers#welcome", as: :welcome
  get "/makeup" => "testers#makeup", as: :makeup
  get "/skincare" => "testers#skincare", as: :skincare
  get "/hair" => "testers#hair", as: :hair
  get "/fragrance" => "testers#fragrance", as: :fragrance
  get "/manage_testers" => "testers#manage", as: :manage
  patch "/trash/:id(.:format)" => "testers#trash", as: :trash
  get "/trashed_testers" => "testers#trashed", as: :trashed

end
