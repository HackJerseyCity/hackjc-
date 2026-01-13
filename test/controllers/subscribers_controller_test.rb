require "test_helper"

class SubscribersControllerTest < ActionDispatch::IntegrationTest
  test "successful subscription creates a subscriber" do
    assert_difference "Subscriber.count", 1 do
      post subscribers_path, params: { subscriber: { email: "new@example.com" } }
    end
  end

  test "successful subscription returns turbo_stream response" do
    post subscribers_path,
         params: { subscriber: { email: "new@example.com" } },
         headers: { "Accept" => "text/vnd.turbo-stream.html" }

    assert_response :success
    assert_match "turbo-stream", response.body
    assert_match "signup_form", response.body
  end

  test "successful subscription redirects for HTML requests" do
    post subscribers_path, params: { subscriber: { email: "new@example.com" } }
    assert_redirected_to root_path
    assert_equal "Thanks for signing up!", flash[:notice]
  end

  test "duplicate email does not create new subscriber" do
    existing = subscribers(:one)

    assert_no_difference "Subscriber.count" do
      post subscribers_path, params: { subscriber: { email: existing.email } }
    end
  end

  test "invalid email shows error via turbo_stream" do
    post subscribers_path,
         params: { subscriber: { email: "invalid" } },
         headers: { "Accept" => "text/vnd.turbo-stream.html" }

    assert_response :success
    assert_match "turbo-stream", response.body
  end

  test "invalid email renders home with unprocessable_entity for HTML" do
    post subscribers_path, params: { subscriber: { email: "invalid" } }
    assert_response :unprocessable_entity
  end
end
