class PrintQueue::PrintJobRulesController < ApplicationController
  before_action :set_print_job_rule, only: [:show, :edit, :update, :destroy]
  skip_before_action  :verify_authenticity_token

  # GET /print_job_rules
  # GET /print_job_rules.json
  def index
    @print_job_rules = PrintQueue::PrintJobRule.all
  end

  # GET /print_job_rules/1
  # GET /print_job_rules/1.json
  def show
  end

  # GET /print_job_rules/new
  def new
    @print_job_rule = PrintQueue::PrintJobRule.new
  end

  # GET /print_job_rules/1/edit
  def edit
  end

  # POST /print_job_rules
  # POST /print_job_rules.json
  def create
    @print_job_rule = PrintQueue::PrintJobRule.new(print_job_rule_params)

    respond_to do |format|
      if @print_job_rule.save
        format.html { redirect_to @print_job_rule, notice: 'Print job rule was successfully created.' }
        format.json { render :show, status: :created, location: @print_job_rule }
      else
        format.html { render :new }
        format.json { render json: @print_job_rule.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /print_job_rules/1
  # PATCH/PUT /print_job_rules/1.json
  def update
    respond_to do |format|
      if @print_job_rule.update(print_job_rule_params)
        format.html { redirect_to print_queue_print_job_rules_path, notice: 'Print job rule was successfully updated.' }
        format.json { render :show, status: :ok, location: @print_job_rule }
      else
        format.html { render :edit }
        format.json { render json: @print_job_rule.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /print_job_rules/1
  # DELETE /print_job_rules/1.json
  def destroy
    @print_job_rule.destroy
    respond_to do |format|
      format.html { redirect_to print_queue_print_job_rules_url, notice: 'Print job rule was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_print_job_rule
      @print_job_rule = PrintQueue::PrintJobRule.find(params[:id]) unless params[:id].blank?
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def print_job_rule_params
      params.require(:print_queue_print_job_rule).permit(:var1, :var2, :var1_type, :var2_type, :operator, :op_is_logic, :option_flag, :option_value, :priority)
    end
end
