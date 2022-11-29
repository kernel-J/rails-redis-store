module ApiKeyAuthenticatable
  extend ActiveSupport::Concern

  include ActionController::HttpAuthentication::Basic::ControllerMethods
  include ActionController::HttpAuthentication::Token::ControllerMethods

  attr_reader :current_api_key
  attr_reader :current_bearer

  # Use this to raise an error and automatically respond with a 401 HTTP status
  # code when API key authentication fails
  def authenticate_with_api_key!
    @current_bearer = authenticate_or_request_with_http_token &method(:authenticator)
  end

  # Use this for optional API key authentication
  def authenticate_with_api_key
    @current_bearer = authenticate_with_http_token &method(:authenticator)
  end

  private

  attr_writer :current_api_key
  attr_writer :current_bearer

  def authenticator(http_token, options)
    api_key = ApiKey.find(token: http_token)

    @current_api_key = if api_key.count == 1
      api_key.first
    else
      nil
    end

    User[current_api_key&.bearer_id]
  end
end
