class Printing::PrintQueueRulesController < ApplicationController
  before_action :set_print_queue_rule, only: [:show, :edit, :update, :destroy]
  after_action :set_weight, only: [:create, :new]
  has_scope :with_user
  has_scope :with_doc_type
  has_scope :with_workstation

  def index
    @print_queue_rules = apply_scopes(Printing::PrintQueueRule).all
  end

  def show
  end

  def new
    @print_queue_rule = Printing::PrintQueueRule.new
  end

  def edit
  end

  def create
    @print_queue_rule = Printing::PrintQueueRule.new(print_queue_rule_params)
    respond_to do |format|
      if @print_queue_rule.save
        flash [:success] = "Print queue rule created."
        format.html { redirect_to printing_print_queue_rules_path }
        format.json { render :index, status: :created, location: @print_queue_rule }
      else
        flash[:danger] = "Print queue rule creation failed."
        format.html { render :new }
        format.json { render json: @print_queue_rule.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @print_queue_rule.update(print_queue_rule_params)
        format.html { redirect_to printing_print_queue_rules_path, notice: 'Print queue_rule was successfully updated.' }
        format.json { render :index, status: :ok, location: @print_queue_rule }
      else
        format.html { render :edit }
        format.json { render json: @print_queue_rule.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @print_queue_rule.destroy
    respond_to do |format|
      format.html { redirect_to printing_print_queue_rules_url, notice: 'Print queue rule was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_print_queue_rule
      @print_queue_rule = Printing::PrintQueueRule.find(params[:id])
    end

    def print_queue_rule_params
      params.require(:printing_print_queue_rule).permit(:user_id, :workstation_id, :document_type_id, :print_queue_id, :weight)
    end

    def set_weight
      if @print_queue_rule.weight.blank?
        if @print_queue_rule.workstation_id.blank?
          if @print_queue_rule.user_id.blank?
            @print_queue_rule.update_attribute(:weight, 1)
          else
            @print_queue_rule.update_attribute(:weight, 3)
          end
        else
          @print_queue_rule.update_attribute(:weight, 5) 
        end
      end
    end
end