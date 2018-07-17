class Admin::PermissionsController < ApplicationController

  before_action :require_admin_permission

  def index
    @permissions = Permission.all
  end

  def edit
    @permission = Permission.find params[:id]
  end

  def update
    @permission = Permission.find params[:id]
    if @permission.update_attributes permission_params
      redirect_to admin_permissions_url, flash: { info: "Successfully updated <code>#{@permission.permission}</code>." }
    else
      render :edit
    end
  end

private

  def require_admin_permission
    require_permission 'sysadmin', 3
  end

  def permission_params
    params.require(:permission).permit(:permission,
                                       :description,
                                       assigned_permissions_attributes: [:id,
                                                                         :user_id,
                                                                         :value,
                                                                         :_destroy])
  end

end