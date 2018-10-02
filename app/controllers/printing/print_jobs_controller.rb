class Printing::PrintJobsController < ApplicationController
  before_action :set_print_job, 
    only: [:show, :edit, :update, :destroy, :send_print_cmd, :set_queue]
    
  skip_before_action :verify_authenticity_token
  skip_before_action :authenticate_user
  require "base64"
  has_scope :with_user
  has_scope :with_doc_type
  has_scope :with_workstation
  has_scope :with_current_user
  has_scope :with_is_complete

  def index
    @print_jobs = apply_scopes(Printing::PrintJob).all.with_is_complete(params[:with_is_complete])
  end

  def show
  end

  def new
    @print_job = Printing::PrintJob.create
  end

  def edit
  end

  def create
    data = Printing::PrintJob.parse_data(params[:data])
    @print_job = Printing::PrintJob.new(data)
    respond_to do |format|
      if @print_job.save
        Printing::PrintJob.set_queue(@print_job)
        Printing::PrintJob.send_print_cmd(@print_job)
        format.html { render :index, notice: 'Print job was successfully created.' }
        format.json { render :index, status: :created, location: @print_job }
      else
        format.html { render :new }
        format.json { render json: @print_job.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @print_job.update(print_job_params)
        format.html { redirect_to printing_print_jobs_path, notice: 'Print job was successfully updated.' }
        format.json { render :index, status: :ok, location: @print_job }
      else
        format.html { render :edit }
        format.json { render json: @print_job.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @print_job.destroy
    respond_to do |format|
      format.html { redirect_to printing_print_jobs_url, notice: 'Print job was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def set_queue
    Printing::PrintJob.set_queue(Printing::PrintJob.find(params[:id]))
    respond_to do |format|
      format.html { redirect_back(fallback_location: "") }
      format.json { head :no_content }
    end
  end

  def send_print_cmd
    Printing::PrintJob.send_print_cmd(@print_job)
    respond_to do |format|
      format.html { redirect_back(fallback_location: "") }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_print_job
      @print_job = Printing::PrintJob.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def print_job_params
      params.require(:printing_print_job).permit(:file, :is_complete, :user_id, :workstation_id, :document_type_id, :description)
    end
end