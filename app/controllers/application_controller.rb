class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # Changes to the importmap will invalidate the etag for HTML responses
  stale_when_importmap_changes

  protect_from_forgery with: :exception
  skip_before_action :verify_authenticity_token, if: :omniauth_request?

  private

  def omniauth_request?
    request.path.start_with?('/users/auth/')
  end
end