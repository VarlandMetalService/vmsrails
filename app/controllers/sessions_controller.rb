class SessionsController < ApplicationController

  skip_before_action  :authenticate_user,
                      only: [:new, :create]

  def new
  end

  def create
    user = User.find_by(username: params[:session][:username].downcase)
    if user && user.authenticate(params[:session][:password])
      helpers.log_in user
      params[:session][:remember_me] == '1' ? helpers.remember(user) : helpers.forget(user)
      redirect_to(session[:return_to] || root_path) and return
    else
      flash.now[:danger] = 'Login failed. Please contact IT for assistance if necessary.'
      render 'new'
    end
  end

  def destroy
    helpers.log_out if helpers.logged_in?
    redirect_to root_url
  end

  def timeclock_new
  end

  def timeclock_create
    user = User.find_by(username: params[:session][:username].downcase)
    if user && user.authenticate(params[:session][:pin])
      helpers.log_in user
      params[:session][:remember_me] == '1' ? helpers.remember(user) : helpers.forget(user)
      redirect_to(session[:return_to] || root_path) and return
    else
      flash.now[:danger] = 'Login failed. Please contact IT for assistance if necessary.'
      render 'new'
    end
  end

end
