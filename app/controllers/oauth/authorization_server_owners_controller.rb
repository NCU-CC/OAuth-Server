module Oauth
  class AuthorizationServerOwnersController < ApplicationController
    before_action :authenticate_authorization_server_owner!

    def index
      @owners = User.where(authorization_server_owner: true)
    end
  end
end
