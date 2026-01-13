require "test_helper"

class SubscriberTest < ActiveSupport::TestCase
  test "valid with a proper email" do
    subscriber = Subscriber.new(email: "test@example.com")
    assert subscriber.valid?
  end

  test "invalid without email" do
    subscriber = Subscriber.new(email: nil)
    assert_not subscriber.valid?
    assert_includes subscriber.errors[:email], "can't be blank"
  end

  test "invalid with duplicate email" do
    Subscriber.create!(email: "dupe@example.com")
    subscriber = Subscriber.new(email: "dupe@example.com")
    assert_not subscriber.valid?
    assert_includes subscriber.errors[:email], "has already been taken"
  end

  test "uniqueness is case insensitive" do
    Subscriber.create!(email: "test@example.com")
    subscriber = Subscriber.new(email: "TEST@EXAMPLE.COM")
    assert_not subscriber.valid?
    assert_includes subscriber.errors[:email], "has already been taken"
  end

  test "invalid with malformed email" do
    invalid_emails = ["invalid", "no-at-sign.com", "@nodomain", "spaces in@email.com"]

    invalid_emails.each do |email|
      subscriber = Subscriber.new(email: email)
      assert_not subscriber.valid?, "#{email} should be invalid"
      assert_includes subscriber.errors[:email], "must be a valid email address"
    end
  end

  test "normalizes email to downcase" do
    subscriber = Subscriber.new(email: "TEST@EXAMPLE.COM")
    assert_equal "test@example.com", subscriber.email
  end

  test "normalizes email by stripping whitespace" do
    subscriber = Subscriber.new(email: "  test@example.com  ")
    assert_equal "test@example.com", subscriber.email
  end
end
