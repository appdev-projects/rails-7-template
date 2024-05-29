# https://github.com/heartcombo/devise/issues/5644
Devise.setup do |config|
  config.secret_key = Rails.application.secret_key_base
end
