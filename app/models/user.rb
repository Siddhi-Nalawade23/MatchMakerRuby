# app/models/user.rb
class User < ApplicationRecord
  # ❌ DELETE this line if it's still there
  # has_secure_password   <-- REMOVE

  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :validatable,
         :omniauthable, omniauth_providers: [ :google_oauth2 ]

  validates :name, presence: true

  def self.from_google(uid:, email:, name:)
    user = find_or_create_by(email: email)
    user.update(
      uid: uid,
      provider: "google_oauth2",
      password: Devise.friendly_token[0, 20]
    )
    user
  end
end
