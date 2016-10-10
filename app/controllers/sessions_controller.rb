class SessionsController < ApplicationController
  protect_from_forgery with: :null_session

  def create
    User.find_or_create_by(portal_id: portal_id)
    session[:portal_id] = portal_id
    redirect_to session[:return_to]
  end

  def portal_id
    request.env['omniauth.auth'].info[:student_id]
  end
end
