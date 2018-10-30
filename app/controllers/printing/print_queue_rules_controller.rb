class Printing::PrintQueueRulesController < ApplicationController
  before_action :set_print_queue_rule, only: [:show, :edit, :update, :destroy]
  after_action :set_weight, only: [:create, :update]
  has_scope :with_user
  has_scope :with_doc_type
  has_scope :with_workstation

  def index
    manage_filter_state
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
        flash[:success] = "Print queue rule created."
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
        flash[:success] = "Print queue rule updated successfully."
        format.html { render :index }
        format.json { render :index }
      else
        format.html { render :index }
        format.json { render json: @print_queue_rule.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @print_queue_rule.destroy
    respond_to do |format|
      flash[:success] = 'Print queue rule was successfully destroyed.'
      format.html { redirect_to printing_print_queue_rules_path }
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
      temp = 0
      if !@print_queue_rule.workstation_id.blank?
          temp += 5
      end
      if !@print_queue_rule.user_id.blank?
          temp += 3
      end
      if !@print_queue_rule.document_type_id.blank?
          temp += 1
      end
      @print_queue_rule.update_attribute(:weight, temp)
    end

    def manage_filter_state
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
      end
    end
end