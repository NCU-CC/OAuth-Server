module ApplicationHelper
  def portal_id
    session[:portal_id]
  end

  def sign_in?
    portal_id.present?
  end

  def user
    return nil unless sign_in?
    User.find_by(portal_id: session[:portal_id])
  end

  def authenticate_authorization_server_owner!
    redirect_to root_path unless authorization_server_owner?
  end

  def authorization_server_owner?
    sign_in? && user.authorization_server_owner
  end

  def errors_for object, method
    if object.errors[method].present?
      object.errors[method].map do |msg|
        content_tag :p do
          msg.capitalize
        end
      end.join.html_safe
    end
  end
end
