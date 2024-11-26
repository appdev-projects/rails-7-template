Rails.application.routes.draw do
  root "users#index"

  devise_for :users, controllers: { registrations: 'user/registrations' }

  resources :survey_responses
  resources :surveys
  resources :reviews


  # Route to display the quiz
  get("/quiz", { :controller => "survey_responses", :action => "new" })

  # Route to handle the form submission
  post("/survey_responses", { :controller => "survey_responses", :action => "create" })

  # Route to display the result
  get("/result", { :controller => "survey_responses", :action => "result" })


  get "/:id" => "users#show", as: :user

end
