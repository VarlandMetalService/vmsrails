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
    unless helpers.logged_in?
      session[:return_to] = request.fullpath
      redirect_to(login_url) and return
    end
    session.delete(:return_to)
    @current_user = helpers.current_user
  end

  def authenticate_admin
    unless helpers.logged_in?
      session[:return_to] = request.fullpath
      redirect_to(login_url) and return
    end
    @current_user = helpers.current_user
    unless @current_user.is_admin
      redirect_back(fallback_location: root_url)
      flash[:danger] = 'You are not authorized to access the page you requested. Admin access is required.'
      return
    end
  end

  def check_permission(right)
    if helpers.current_user.nil?
      obj = nil
    else
      obj ||= helpers.current_user.permissions.find_by_permission right
    end
    if obj.nil?
      @access_level = 0
    else
      @access_level = obj.access_level
    end
  end

  def require_permission(right, level)
    check_permission(right)
    if @access_level < level
      redirect_back(fallback_location: root_url, flash: { danger: 'Permission denied. Please contact IT if you have questions.' }) and return
    end
  end

end
