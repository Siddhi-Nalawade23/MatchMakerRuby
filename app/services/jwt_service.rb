# app/services/jwt_service.rb
class JwtService
  ALGORITHM = 'HS256'.freeze
  ISSUER    = 'JwtIssuer'.freeze
  AUDIENCE  = 'JwtAudience'.freeze
  EXPIRY    = 24.hours

  def self.encode(user)
    payload = {
      user_id: user.id.to_s,
      name:    user.name.to_s,
      email:   user.email.to_s,
      phone:   user.phone.to_s,
      role:    user.role.to_s,
      exp:     EXPIRY.from_now.to_i,
      iss:     ISSUER,
      aud:     AUDIENCE
    }
    JWT.encode(payload, secret_key, ALGORITHM)
  end

  def self.decode(token)
    JWT.decode(
      token,
      secret_key,
      true,
      algorithm:  ALGORITHM,
      iss:        ISSUER,
      aud:        AUDIENCE,
      verify_iss: true,
      verify_aud: true
    ).first
  rescue JWT::ExpiredSignature
    raise StandardError, 'Token has expired'
  rescue JWT::DecodeError => e
    raise StandardError, "Invalid token: #{e.message}"
  end

  def self.secret_key
    Rails.application.credentials.jwt_secret_key ||
      ENV.fetch('JWT_SECRET_KEY') { raise 'JWT_SECRET_KEY is not set!' }
  end
end