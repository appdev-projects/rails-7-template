Rails.application.routes.draw do
  root "home#index"

  devise_for :users

  resources :survey_responses
  resources :surveys
  resources :reviews


  # This is a blank app! Pick your first screen, build out the RCAV, and go from there. E.g.:

  # get "/your_first_screen" => "pages#first"
  
end
