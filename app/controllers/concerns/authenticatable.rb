# app/controllers/concerns/authenticatable.rb
module Authenticatable
  extend ActiveSupport::Concern

  included do
    before_action :authenticate_request
  end

  private

  def authenticate_request
    header = request.headers["Authorization"]
    token = header&.split(" ")&.last # expecting "Bearer <token>"

    if token.nil?
      render json: { error: "Authorization token missing" }, status: :unauthorized
      return
    end

    begin
      @decoded_token = JwtService.decode(token)
      @current_user_id = @decoded_token["user_id"]
    rescue StandardError => e
      render json: { error: e.message }, status: :unauthorized
    end
  end
end