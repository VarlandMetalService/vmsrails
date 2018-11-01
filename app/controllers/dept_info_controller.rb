class DeptInfoController < ApplicationController

  skip_before_action  :authenticate_user

  has_scope :with_search_term,
            only: :index
  has_scope :changed_after,
            only: :index
  has_scope :changed_before,
            only: :index

  def index
    @folders = DeptInfo::Folder.roots
    @newest  = DeptInfo::Document.unscoped.changed_after(6.months.ago).order(updated_at: :desc).limit(20)
    if params[:with_search_term] || params[:changed_after] || params[:changed_before]
      @search_results = apply_scopes(DeptInfo::Document).all.includes(:folders)
    end
  end

  def update
    loader = DeptInfo::Loader.new()
    loader.load()
    redirect_back fallback_location: dept_info_url, success: "Finished updating Departmental Information."
  end

end
