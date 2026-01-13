require "application_system_test_case"

class SignupsTest < ApplicationSystemTestCase
  test "visitor can sign up from homepage" do
    visit root_path

    fill_in "subscriber[email]", with: "visitor@example.com"
    click_button "Join"

    assert_text "You're in"
    assert Subscriber.exists?(email: "visitor@example.com")
  end

  test "visitor sees error for duplicate email" do
    Subscriber.create!(email: "taken@example.com")

    visit root_path

    fill_in "subscriber[email]", with: "taken@example.com"
    click_button "Join"

    assert_text "has already been taken"
  end
end
