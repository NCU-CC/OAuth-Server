module Oauth
  class DisabledUsersController < ApplicationController
    before_action :authenticate_authorization_server_owner!
    before_action :set_disabled_user, only: [:destroy]

    def index
      @disabled_users = User.where(disabled: true)
    end

    def destroy
      @disabled_user.disabled = false
      flash[:notice] = I18n.t('notice.disabled_user.destroy') if @disabled_user.save
      redirect_to oauth_disabled_users_path
    end

    private

    def set_disabled_user
      @disabled_user = User.where(disabled: true).find_by(id: params[:id])
    end
  end
end
