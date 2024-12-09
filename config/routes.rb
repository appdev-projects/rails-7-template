Rails.application.routes.draw do
  draw(:admin)
  devise_for :users, controllers: { 
    registrations: "user/registrations", 
  }

  root "users#home"

  resources :users
  resources :surveys
  resources :messages

  get("/quiz", { controller: "surveys", action: "new" })
  post("/survey", { controller: "surveys", action: "create" })
  get("/result", { controller: "surveys", action: "result" })

  get("/underconstruction", { controller: "users", action: "underconstruction" })

  get("/messages/conversation/:user_id", { controller: "messages", action: "conversation" })

  get "/:id" => "users#show"
end
