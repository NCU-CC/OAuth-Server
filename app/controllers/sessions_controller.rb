class SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    User.find_or_create_by(portal_id: portal_id)
    session[:portal_id] = portal_id
    redirect_to session[:return_to]
  end

  def destroy
    reset_session
    redirect_to root_path
  end

  def portal_id
    request.env['omniauth.auth'].info[:student_id]
  end
end
