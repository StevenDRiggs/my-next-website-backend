class User < ApplicationRecord
  has_secure_password
  has_many :comments
  has_many :posts, through: :comments
  validates :username, :email, :password, presence: true
  validates :username, :email, uniqueness: true
  validates :username, profanity_filter: true

  # class methods

  def self.find_by_username_or_email(username_or_email)

    user = self.find_by(username: username_or_email)
    unless user
      user = self.find_by(email: username_or_email)
    end

    return user
  end


  # instance methods

  def usernameOrEmail=(username_or_email)
    # method defined only for parameter acceptance; should always be empty string
  end
end
