class SpecificationsController < ApplicationController

  before_action :check_user_permission,
                only: :index
  before_action :require_user_permission,
                only: :archived
  before_action :require_admin_permission
  skip_before_action  :require_admin_permission,
                      only: [:index, :archived]

  has_scope :with_search_term, only: :index
  has_scope :with_organization, only: :index
  has_scope :with_name, only: :index
  has_scope :with_classification, only: :index
  has_scope :with_process_code, only: :index
  has_scope :with_color, only: :index
  has_scope :with_ss_white_spec, only: :index
  has_scope :with_ss_red_spec, only: :index
  has_scope :with_min_alloy_percentage, only: :index
  has_scope :with_max_alloy_percentage, only: :index
  has_scope :with_min_thickness, only: :index
  has_scope :with_max_thickness, only: :index
  has_scope :with_bake_temperature, only: :index
  has_scope :with_bake_variation_limit, only: :index
  has_scope :with_bake_time, only: :index
  has_scope :with_bake_within_limit, only: :index
  has_scope :with_inert_bake, only: :index

  def index
    @specifications = apply_scopes(Specification.without_archived).includes(:classifications).page(params[:page])
    @unpaged_specifications = apply_scopes(Specification.without_archived).includes(:classifications)
    @sql = apply_scopes(Specification.without_archived).page(params[:page]).to_sql
  end

  def archived
    @specifications = apply_scopes(Specification.archived).includes(:classifications).page(params[:page])
    @unpaged_specifications = apply_scopes(Specification.archived).includes(:classifications)
    @sql = apply_scopes(Specification.archived).page(params[:page]).to_sql
    render :action => 'index'
  end

  def deleted
    @specifications = apply_scopes(Specification.only_deleted).includes(:classifications).page(params[:page])
    @unpaged_specifications = apply_scopes(Specification.only_deleted).includes(:classifications)
    @sql = apply_scopes(Specification.only_deleted).page(params[:page]).to_sql
    render :action => 'index'
  end

  def new
    @specification = Specification.new
  end

  def create
    @specification = Specification.new(specification_params) 
    if @specification.save
      redirect_to specifications_url
    else
      render :action => 'new'
    end 
  end

  def edit
    @specification = Specification.find(params[:id])
  end

  def archive
    specification = Specification.find(params[:id])
    specification.archived_at = Time.now
    specification.save
    flash[:info] = "#{specification.title} has been archived. View <a href=\"#{archived_specifications_url}\">archived specifications</a>."
    redirect_back(fallback_location: specifications_url) and return
  end

  def unarchive
    specification = Specification.find(params[:id])
    specification.archived_at = nil
    specification.save
    flash[:info] = "#{specification.title} has been un-archived. View <a href=\"#{specifications_url}\">current specifications</a>."
    redirect_back(fallback_location: specifications_url)
  end

  def undelete
    specification = Specification.only_deleted.find(params[:id])
    specification.recover
    flash[:info] = "#{specification.title} has been un-deleted. View <a href=\"#{specifications_url}\">current specifications</a>."
    redirect_back(fallback_location: specifications_url)
  end

  def duplicate
    specification = Specification.find(params[:id])
    new_specification = specification.dup
    new_specification.name << " Copy"
    new_specification.save
    specification.classifications.each do |c|
      new_classification = c.dup
      new_classification.specification = new_specification
      new_classification.save
    end
    flash[:info] = "#{specification.title} has been duplicated as #{new_specification.title}."
    redirect_to specifications_url
  end

  def update
    @specification = Specification.find params[:id]
    if @specification.update_attributes(specification_params)
      redirect_to specifications_url
      return
    else
      render :action => 'edit'
    end 
  end

  def destroy
    @specification = Specification.find(params[:id])
    @specification.archived_at = nil
    @specification.save
    @specification.destroy
    flash[:info] = "#{@specification.title} has been deleted. View <a href=\"#{deleted_specifications_url}\">deleted specifications</a>."
    redirect_back(fallback_location: specifications_url)
  end

private

  def check_user_permission
    check_permission 'specifications'
  end

  def require_user_permission
    require_permission 'specifications', 2
  end

  def require_admin_permission
    require_permission 'specifications', 3
  end

  def specification_params
    params.require(:specification).permit(:organization,
                                          :name,
                                          :description,
                                          :revision,
                                          :notes,
                                          :file,
                                          :file_cache,
                                          classifications_attributes: [:id,
                                                                       :name,
                                                                       :description,
                                                                       :vms_process_code,
                                                                       :color,
                                                                       :minimum_alloy_percentage,
                                                                       :maximum_alloy_percentage,
                                                                       :minimum_thickness,
                                                                       :maximum_thickness,
                                                                       :thickness_unit,
                                                                       :salt_spray_white_spec,
                                                                       :salt_spray_red_spec,
                                                                       :bake_setpoint,
                                                                       :bake_variation_limit,
                                                                       :bake_temperature_unit,
                                                                       :bake_soak_length,
                                                                       :bake_within_limit,
                                                                       :bake_requires_inert_atmosphere,
                                                                       :notes,
                                                                       :not_capable,
                                                                       :_destroy])
  end

end