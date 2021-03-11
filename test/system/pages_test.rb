require "application_system_test_case"

class PagesTest < ApplicationSystemTestCase
  test "Title and content is good on homepage" do
    visit "/"

    assert_selector "h1", text: "LazyReader"
    assert_selector ".tagline", text: "Accurate information, no reading."
    assert_selector ".btn.btn-flat", text: "Let's go !"
  end
end
