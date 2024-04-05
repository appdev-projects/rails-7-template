Rails.application.routes.draw do
  resources :programs 
  resources :curriculums
  devise_for :users
  resources :schools
  resources :students
  get 'home/index'
 
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root to: "home#index"
  # root "articles#index"
end
