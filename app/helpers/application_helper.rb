module ApplicationHelper
  def portal_id
    session[:portal_id]
  end

  def sign_in?
    portal_id.present? && current_user.present?
  end

  def current_user
    @current_user ||= User.find_by(portal_id: session[:portal_id])
  end

  def authenticate_authorization_server_owner!
    redirect_to root_path unless authorization_server_owner?
  end

  def authorization_server_owner?
    sign_in? && current_user.authorization_server_owner
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

  def meta_tag name, content
    tag :meta, name: name.to_s, content: content
  end
end
