module Oauth
  class AuthorizationServerOwnersController < ApplicationController
    before_action :authenticate_authorization_server_owner!
    before_action :set_owner, only: [:destroy]

    def index
      @owners = User.where(authorization_server_owner: true)
    end

    def destroy
      @owner.authorization_server_owner = false
      flash[:notice] = I18n.t('notice.owner.destroy') if @owner.save
      redirect_to oauth_owners_path
    end

    private

    def set_owner
      @owner = User.where(authorization_server_owner: true).find_by(id: params[:id])
    end
  end
end
