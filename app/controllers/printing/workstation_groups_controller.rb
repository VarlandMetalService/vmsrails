class Printing::WorkstationGroupsController < ApplicationController
  before_action :set_workstation_group, only: [:show, :edit, :update, :destroy]
  has_scope :with_search_term,    only: :index

  def index
    @workstation_groups = apply_scopes(Printing::WorkstationGroup).all
  end

  def show
  end

  def new
    @workstation_group = Printing::WorkstationGroup.new
  end

  def edit
  end

  def create
    @workstation_group = Printing::WorkstationGroup.new(workstation_group_params)

    respond_to do |format|
      if @workstation_group.save
        format.html { redirect_to printing_workstation_groups_path, notice: 'Workstation Group was successfully created.' }
        format.json { redirect_to printing_workstation_groups_path, status: :created, location: @workstation_group }
      else
        format.html { render :new }
        format.json { render json: @workstation_group.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @workstation_group.update(workstation_group_params)
        format.html { redirect_to printing_workstation_groups_path, notice: 'Print queue was successfully updated.' }
        format.json { redirect_to printing_workstation_groups_path, status: :ok, location: @workstation_group }
      else
        format.html { render :edit }
        format.json { render json: @workstation_group.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @workstation_group.destroy
    respond_to do |format|
      format.html { redirect_to printing_workstation_groups_url, notice: 'Print queue was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_workstation_group
      @workstation_group = Printing::WorkstationGroup.find(params[:id])
    end

    def workstation_group_params
      params.require(:printing_workstation_group).permit(:name, :description, workstation_ids:[])
    end
end