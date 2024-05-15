Rails.application.routes.draw do
  devise_for :users
  root to: "posts#index"
  #get("/", { :controller => "posts", :action => "index" })
  # Routes for the Reply resource:

  # CREATE
  post("/insert_reply", { :controller => "replies", :action => "create" })
          
  # READ
  get("/replies", { :controller => "replies", :action => "index" })
  
  get("/replies/:path_id", { :controller => "replies", :action => "show" })
  
  # UPDATE
  
  post("/modify_reply/:path_id", { :controller => "replies", :action => "update" })
  
  # DELETE
  get("/delete_reply/:path_id", { :controller => "replies", :action => "destroy" })

  #------------------------------

  # Routes for the Post resource:

  # CREATE
  post("/insert_post", { :controller => "posts", :action => "create" })
          
  # READ
  get("/posts", { :controller => "posts", :action => "index" })
  
  get("/posts/:path_id", { :controller => "posts", :action => "show" })
  
  # UPDATE
  
  post("/modify_post/:path_id", { :controller => "posts", :action => "update" })
  
  # DELETE
  get("/delete_post/:path_id", { :controller => "posts", :action => "destroy" })

  #------------------------------

  # This is a blank app! Pick your first screen, build out the RCAV, and go from there. E.g.:

  # get "/your_first_screen" => "pages#first"
  
end
