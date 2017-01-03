module Oauth
  class TokenInfoController < Doorkeeper::ApplicationMetalController
    def show
      request.headers['Authorization'] = "Bearer #{params[:token_string]}"
      if doorkeeper_token && doorkeeper_token.accessible?
        render json: doorkeeper_token.to_old_format, status: :ok
      else
        error = Doorkeeper::OAuth::ErrorResponse.new(name: :invalid_request)
        response.headers.merge!(error.headers)
        render json: error.body, status: error.status
      end
    end
  end
end
