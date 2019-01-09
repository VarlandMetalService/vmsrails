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
  has_scope :with_description

  def index
    filters_to_cookies
    @print_jobs = apply_scopes(Printing::PrintJob).includes(:document_type, :print_queue, :workstation, :user).with_is_complete(params[:with_is_complete]).page(params[:page])
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
        flash[:success] = 'Print job was created.'
        format.html { render :index }
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
        flash[:success] = 'Print job was updated.'
        format.html { redirect_to printing_print_jobs_path }
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
      flash[:danger] = 'Print job was destroyed'
      format.html { redirect_to printing_print_jobs_url }
      format.json { head :no_content }
    end
  end

  def set_queue
    Printing::PrintJob.set_queue(@print_job)
    respond_to do |format|
      if @print_job.print_queue.blank?
      else
      flash[:success] = "Print queue set to #{@print_job.print_queue.name}"
      end
      format.html { redirect_back(fallback_location: "") }
      format.json { head :no_content }
    end
  end

  def send_print_cmd
    Printing::PrintJob.send_print_cmd(@print_job)
    respond_to do |format|
      if @print_job.is_complete
        flash[:success] = "Print job successfully printed."
      else
        flash[:danger] = "Print job failed to print"
      end
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

    def filters_to_cookies
      if params[:reset]
        cookies[:with_user] = ""
        cookies[:with_doc_type] = ""
        cookies[:with_workstation] = ""
      else
        if params[:with_user]
          cookies[:with_user] = { value: params[:with_user], expires: 1.day.from_now }
        else
          if cookies[:with_user]
            params[:with_user] = cookies[:with_user]
          end
        end
        if params[:with_doc_type]
          cookies[:with_doc_type] = { value: params[:with_doc_type], expires: 1.day.from_now }
        else
          if cookies[:with_doc_type]
            params[:with_doc_type] = cookies[:with_doc_type]
          end
        end
        if params[:with_workstation]
          cookies[:with_workstation] = { value: params[:with_workstation], expires: 1.day.from_now }
        else
          if cookies[:with_workstation]
            params[:with_workstation] = cookies[:with_workstation]
          end
        end
        if params[:with_is_complete]
          cookies[:with_is_complete] = { value: params[:with_is_complete], expires: 1.day.from_now }
        else
          if cookies[:with_is_complete]
            params[:with_is_complete] = cookies[:with_is_complete]
          end
        end
      end
    end
end