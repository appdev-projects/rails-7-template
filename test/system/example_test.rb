require "application_system_test_case"

class MoviesTest < ApplicationSystemTestCase
  test "visiting the index" do
    visit "/movies"
    assert_selector "h1", text: "List of all movies"
  end
end
