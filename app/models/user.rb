class User < ApplicationRecord
  has_secure_password

  validates :username, uniqueness: true

   def self.login!(username:, password:)
    user = User.find_by!(username: username)
    raise ActiveRecord::RecordNotFound unless user.authenticate(password)
    user.update_attribute(:session_token, SecureRandom.urlsafe_base64)
    user
  end
end
