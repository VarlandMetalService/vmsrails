module Thickness
  class ChecksController < ApplicationController
    before_action :set_check, only: [:show, :edit, :update, :destroy]

    def index
      @check = apply_scopes(check).all.page(params[:page])
  
      respond_to do |format|
        format.html
        format.json { render :json => @check }
      end
    end
  
    def show
    end
  
    def new
      @check = check.new
    end
  
    def edit
    end
  
    def create
      @check = check.new
      if @check.save
        flash[:success] = "check created."
        respond_to do |format|
          format.html { redirect_to check_path(@check)}
          format.json { render :json => @check }
        end
      else
        render :action => 'new'
        Rails.logger.info(@check.errors.inspect)
      end 
    end
  
    def update
        if @check.update(check_params)
          flash[:success] = "check updated."
          redirect_to check_path(@check)
        else
          render 'edit'
        end
    end
  
    def destroy
      @check.destroy
      respond_to do |format|
        format.html { redirect_to checks_url, notice: 'check was successfully destroyed.' }
        format.json { head :no_content }
      end
    end
  
    private
      # Select check by id.
      def set_check
        @check = check.find(params[:id])
      end
  
      # Never trust parameters from the internet, only allow the white list.
      def check_params
        params.require(:check).permit(:id, :block_id, :check_timestamp, :check_num, :thickness, :alloy_percentage, :x, :y, :z)
      end 
  end
end