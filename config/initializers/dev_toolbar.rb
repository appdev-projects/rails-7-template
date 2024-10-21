if Rails.env.development?
  DevToolbar.configure do |config|
    config.links = [
      { name: "Routes", path: "/rails/info/routes" },
      { name: "Database", path: "/rails/db" },
      { name: "Data Model", path: "/erd.png" }
    ]
  end
end
