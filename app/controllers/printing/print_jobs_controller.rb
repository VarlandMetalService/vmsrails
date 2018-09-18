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

  def index
    @print_jobs = apply_scopes(Printing::PrintJob).all
  end

  def show
  end

  def new
    @print_job = Printing::PrintJob.new
  end

  def edit
  end

  def create
    data = parse_data(params[:data])
    @print_job = Printing::PrintJob.new(data)
    respond_to do |format|
      if @print_job.save
        set_queue
        send_print_cmd
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

  def send_print_cmd
    queue = Printing::PrintQueue.find(@print_job.print_queue_id)
    cmd = "lpr "
    cmd << queue.printer << " " << queue.options << " "
    cmd << @print_job.file.current_path
    @print_job.update_attribute(:is_complete,                                     system(cmd))
    respond_to do |format|
      format.html { redirect_back(fallback_location: "") }
      format.json { head :no_content }
    end
  end

  def set_queue
    p = @print_job
    applicable_rules = []
    Printing::PrintQueueRule.all.each do |r|
      if r.user_id == p.user_id || r.user_id.blank?
        if r.workstation_id == p.workstation_id || r.workstation_id.blank?
          if r.document_type_id == p.document_type_id ||    r.document_type_id.blank?
            applicable_rules << r
          end
        end
      end
    end
    applicable_rules = applicable_rules.sort_by { |x| -x[:weight] }
    applicable_rules.each do |y|
    end
    p.update_attribute(:print_queue_id, applicable_rules.first.print_queue_id)
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
      params.require(:printing_print_job).permit(:file, :is_complete, :user_id, :workstation_id, :document_type_id)
    end

    # Parse incoming json into file/options
    def parse_data(dat)
      data = {}
      temp = JSON.parse(dat)
      temp.symbolize_keys!
      temp[:file].gsub!(' ', '+')

      data[:file] = temp[:file]
      data[:user_id] = temp[:user]
      # data[:user_id] = User.find_by username: temp[:user]
      # data[:workstation_id] = Workstation.find_by ip: request.remote_ip
      # data[:document_type_id] = DocumentType.find_by name: temp[:document_type]  
      return data
    end
end