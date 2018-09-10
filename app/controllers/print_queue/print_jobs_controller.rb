class PrintQueue::PrintJobsController < ApplicationController
  before_action :set_print_job, only: [:show, :edit, :update, :destroy, :send_print_cmd]
  after_action :send_print_cmd, only: [:create]
  skip_before_action  :verify_authenticity_token
  require "base64"

  # GET /print_jobs
  # GET /print_jobs.json
  def index
    @print_jobs = PrintQueue::PrintJob.all
  end

  def fail_index
    @print_jobs = PrintQueue::PrintJob.all.where(fail_flag: true)
  end

  # GET /print_jobs/1
  # GET /print_jobs/1.json
  def show
  end

  # GET /print_jobs/new
  def new
    @print_job = PrintQueue::PrintJob.new
  end

  # GET /print_jobs/1/edit
  def edit
  end

  # POST /print_jobs
  # POST /print_jobs.json
  def create
    data = parse_data(params[:data])
    @print_job = PrintQueue::PrintJob.new(data)
    respond_to do |format|
      if @print_job.save
        @print_job.update_attribute(:lpr_command, PrintQueue::PrintJob.build_lpr_command(PrintQueue::PrintJob.find_applicable_rules(@print_job.id), @print_job.id))
        format.html { redirect_to @print_job, notice: 'Print job was successfully created.' }
        format.json { render :show, status: :created, location: @print_job }
      else
        format.html { render :new }
        format.json { render json: @print_job.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /print_jobs/1
  # PATCH/PUT /print_jobs/1.json
  def update
    respond_to do |format|
      if @print_job.update(print_job_params)
        format.html { redirect_to print_queue_print_jobs_path, notice: 'Print job was successfully updated.' }
        format.json { render :show, status: :ok, location: @print_job }
      else
        format.html { render :edit }
        format.json { render json: @print_job.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /print_jobs/1
  # DELETE /print_jobs/1.json
  def destroy
    @print_job.destroy
    respond_to do |format|
      format.html { redirect_to print_queue_print_jobs_url, notice: 'Print job was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def send_print_cmd
    @print_job.update_attribute(:fail_flag,                                     !system("#{@print_job.lpr_command}"))
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_print_job
      @print_job = PrintQueue::PrintJob.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def print_job_params
      params.require(:print_queue_print_job).permit(:user, :file, :file_type, :fail_flag, :lpr_command, :workstation)
    end

    # Parse incoming json into file/options
    def parse_data(dat)
      data = JSON.parse(dat)
      data.symbolize_keys!
      data[:file].gsub!(' ', '+')
      return data
    end
end