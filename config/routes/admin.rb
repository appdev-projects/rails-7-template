authenticate :user, ->(user) { user.admin? } do
  mount RailsAdmin::Engine, at: "admin", as: "rails_admin"
end
