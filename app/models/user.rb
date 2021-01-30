class User < ApplicationRecord
  has_secure_password
  has_many :comments
  validates :username, :email, :password, presence: true
  validates :username, profanity_filter: true
end
