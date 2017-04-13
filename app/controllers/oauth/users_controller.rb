module Oauth
  class UsersController < ApplicationController

    before_action :authenticate_authorization_server_owner!
    before_action :set_user, only: [:show, :update]

    def index
      @users = User.order(authorization_server_owner: :desc)
    end

    def show
      @applications = @user.oauth_applications
    end

    private

    def set_user
      @user = User.find(params[:id])
    end
  end
end
