class SessionsController < Doorkeeper::ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create, :destroy]
  add_flash_types :sign

  def index
    redirect_to root_path
  end

  def new
    authenticate_admin!
  end

  def create
    User.find_or_create_by(portal_id: portal_id)
    session[:portal_id] = portal_id
    redirect_to session[:return_to]
  end

  def destroy
    reset_session
    redirect_to root_path, sign: 'out'
  end

  private

  def portal_id
    request.env['omniauth.auth'].uid[/\/([^\/]*)$/, 1]
  end
end
