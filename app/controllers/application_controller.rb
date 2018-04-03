class ApplicationController < ActionController::Base
  
  protect_from_forgery with: :exception

  before_action :authenticate_user
  before_action :initialize_body_classes

  private

  def auto_refresh(delay = 30)
    @auto_refresh_delay = delay
    render
  end

  def initialize_body_classes
    @body_classes = ["#{params[:controller]}-controller"]
  end

  def remove_nav_xs
    @body_classes << 'no-nav-xs'
  end

  def reference_user
    @current_user = helpers.current_user
  end

  def authenticate_user
    redirect_to(login_url) and return unless helpers.logged_in?
    @current_user = helpers.current_user
  end

  def authenticate_admin
    redirect_to(login_url) and return unless helpers.logged_in?
    @current_user = helpers.current_user
    unless @current_user.is_admin
      redirect_to root_url
      flash.now[:danger] = 'You are not authorized to access the page you requested. Admin access is required.'
      return
    end
  end

end
