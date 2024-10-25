if Object.const_defined?('RailsDb')
  RailsDb.setup do |config|
    # only enable the gem if environment variables are set for username and password
    if ENV.fetch("RAILS_DB_USERNAME", nil).present? && ENV.fetch("RAILS_DB_PASSWORD", nil).present?
      # enable
      config.enabled = true

      # automatic engine routes mounting
      config.automatic_routes_mount = true

      # set tables which you want to hide ONLY
      config.black_list_tables = ["ar_internal_metadata"]

      # Enable http basic authentication
      config.http_basic_authentication_enabled = true

      # Enable http basic authentication
      config.http_basic_authentication_user_name = ENV.fetch("RAILS_DB_USERNAME")

      # Enable http basic authentication
      config.http_basic_authentication_password = ENV.fetch("RAILS_DB_PASSWORD")
    else
      config.enabled = false
      config.automatic_routes_mount = false
    end
  end
end
