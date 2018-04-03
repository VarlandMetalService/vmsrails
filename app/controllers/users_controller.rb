class UsersController < ApplicationController

  skip_before_action  :authenticate_user
  before_action :authenticate_admin

  has_scope :by_name,
            only: :index
  has_scope :by_category,
            only: :index

  def index
    @users = apply_scopes(User).all.order(:employee_number)
  end

  def edit
    @user = User.unscoped.find params[:id]
  end

  def update
    @user = User.unscoped.find params[:id]
    if @user.update_attributes(user_params)
      flash[:success] = "Successfully updated #{@user.nickname}."
      redirect_to users_url
      return
    else
      render 'edit'
    end
  end

private

  def user_params
    params.require(:user).permit(:is_disabled,
                                 :is_admin,
                                 :initials,
                                 :email,
                                 :nickname,
                                 :avatar_bg_color,
                                 :avatar_text_color)
  end

end
