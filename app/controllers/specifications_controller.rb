class SpecificationsController < ApplicationController

  skip_before_action  :authenticate_user

  has_scope :with_search_term, only: :index
  has_scope :with_organization, only: :index
  has_scope :with_name, only: :index
  has_scope :with_classification, only: :index
  has_scope :with_process_code, only: :index
  has_scope :with_color, only: :index

  def index
    @specifications = apply_scopes(Specification).page(params[:page])
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
    @specification.destroy
    redirect_to specifications_url
  end

private

  def specification_params
    params.require(:specification).permit(:organization,
                                          :name,
                                          :description,
                                          :revision,
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
                                                                       :_destroy])
  end

end