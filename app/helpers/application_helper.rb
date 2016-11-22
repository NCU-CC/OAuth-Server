module ApplicationHelper
  def portal_id
    session[:portal_id]
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
