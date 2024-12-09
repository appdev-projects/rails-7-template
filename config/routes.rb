Rails.application.routes.draw do
  draw(:admin)

  root "users#home"

  devise_for :users, controllers: { registrations: "user/registrations" }

  resources :users
  resources :survey_responses
  resources :surveys
  resources :messages

  # Route to display the users' page (index)
  # get("/pals", { :controller => "users", :action => "pals" })

  # Route to display the quiz
  get("/quiz", { :controller => "surveys", :action => "new" })

  # Route to handle the form submission
  post("/survey", { :controller => "surveys", :action => "create" })

  # Route to display the result
  get("/result", { :controller => "surveys", :action => "result" })

  get("/underconstruction", { :controller => "users", :action => "underconstruction" })

  # Routes to display the messages
  get("/messages/conversation/:user_id", { :controller => "messages", :action => "conversation" })

  get "/:id" => "users#show"
end
