require "test_helper"

class PagesControllerTest < ActionDispatch::IntegrationTest
  test "home page renders successfully" do
    get root_path
    assert_response :success
  end

  test "home page assigns a new subscriber" do
    get root_path
    assert_select "form[action=?]", subscribers_path
    assert_select "input[type=email][name=?]", "subscriber[email]"
  end
end
