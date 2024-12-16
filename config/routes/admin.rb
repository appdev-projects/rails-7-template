authenticate :user, ->(user) { user.admin? } do
  mount Blazer::Engine, at: "blazer"
  mount RailsAdmin::Engine, at: "admin", as: "rails_admin"
  mount GoodJob::Engine => "good_job"
end
