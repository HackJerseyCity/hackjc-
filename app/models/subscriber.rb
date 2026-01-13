class Subscriber < ApplicationRecord
  EMAIL_FORMAT = /\A[^@\s]+@[^@\s]+\z/

  normalizes :email, with: ->(email) { email.downcase.strip }

  validates :email, presence: true,
                    uniqueness: { case_sensitive: false },
                    format: { with: EMAIL_FORMAT, message: "must be a valid email address" }
end
