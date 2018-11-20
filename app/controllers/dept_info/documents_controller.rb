
class DeptInfo::DocumentsController < ApplicationController
  skip_before_action  :authenticate_user

  def show
    begin
      @document = DeptInfo::Document.find params[:id]
    rescue ActiveRecord::RecordNotFound
      flash.now[:error] = 'Error loading document. Please contact IT for assistance.'
      redirect_to controller: 'dept_info', action: 'index'
    end
  end
end