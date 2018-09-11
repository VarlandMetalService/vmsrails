class SessionsController < ApplicationController

  skip_before_action  :authenticate_user,
                      only: [:new, :create, :timeclock_new, :timeclock_create]

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
    redirect_back(fallback_location: root_path)
  end

  def timeclock_new
  end

  def timeclock_create
    password = { :pin => params[:pin_num]}
    user = User.find_by(employee_number: params[:user_num])
    puts user.pin.to_i
    if user.pin.to_i == params[:pin_num].to_i
      helpers.log_in user
      helpers.forget(user)
      redirect_to('/timeclock') and return
    else
      flash.now[:danger] = 'Login failed. Please contact IT for assistance if necessary.'
    end
  end

end
