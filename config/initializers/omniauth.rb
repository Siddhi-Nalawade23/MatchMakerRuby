# config/initializers/omniauth.rb
OmniAuth.config.allowed_request_methods = [:get, :post]
OmniAuth.config.silence_get_warning = true
OmniAuth.config.on_failure = Proc.new { |env|
OmniAuth::FailureEndpoint.new(env).redirect_to_failure
}