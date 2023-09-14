require "test_helper"
require_relative "../spec/support/headless_chrome"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :selenium, using: :headless_chrome
end
