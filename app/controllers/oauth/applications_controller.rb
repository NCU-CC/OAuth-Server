class Oauth::ApplicationsController < Doorkeeper::ApplicationsController
  include ApplicationHelper
  skip_before_action :authenticate_admin!
  prepend_before_action :set_user

  def index
    @applications = @user.oauth_applications
  end

  # only needed if each application must have some owner
  def create
    @application = Doorkeeper::Application.new(application_params)
    @application.owner = @user if Doorkeeper.configuration.confirm_application_owner?
    if @application.save
      flash[:notice] = I18n.t(:notice, :scope => [:doorkeeper, :flash, :applications, :create])
      redirect_to oauth_application_url(@application)
    else
      render :new
    end
  end

  private

  def set_user
    @user = authenticate_admin!
  end

  def set_application
    if authorization_server_owner?
      @application = Doorkeeper::Application.find(params[:id])
    else
      @application = @user.oauth_applications.find(params[:id])
    end
  end
end
