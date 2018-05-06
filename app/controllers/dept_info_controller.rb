class DeptInfoController < ApplicationController

  skip_before_action  :authenticate_user

  has_scope :with_search_term,
            only: :index

  def index
    @folders = DeptInfo::Folder.roots
    @newest = DeptInfo::Document.unscoped.order(updated_at: :desc).limit(5)
    if params[:with_search_term]
      @search_results = apply_scopes(DeptInfo::Document).all
    end
  end

  def update
    loader = DeptInfo::Loader.new()
    loader.load()
    redirect_back fallback_location: dept_info_url, success: "Finished updating Departmental Information."
  end

end
