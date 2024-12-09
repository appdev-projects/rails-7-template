require 'rails_helper'

RSpec.feature "User Authentication", type: :feature do
  scenario "User signs up, logs in, and logs out" do
    visit new_user_registration_path

    fill_in "Email", with: "user@example.com"
    fill_in "password", with: "password"
    click_link "Sign up"

    visit new_user_session_path
    fill_in "Email", with: "user@example.com"
    fill_in "password", with: "password"
    click_button "Log In"
  end
end
