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

    def update
      @user.authorization_server_owner = params[:user][:authorization_server_owner]
      @user.disabled = params[:user][:disabled]
      @user.save
      render json: @user
    end

    private

    def set_user
      @user = User.find(params[:id])
    end
  end
end
