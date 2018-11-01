module Thickness
  class BlocksController < ApplicationController
    before_action :set_block, only: [:show, :edit, :update, :destroy]
    skip_before_action :authenticate_user
    skip_before_action :verify_authenticity_token
    
    has_scope :with_timestamp,    only: :index
    has_scope :with_directory,    only: :index
    has_scope :with_product,      only: :index
    has_scope :with_application,  only: :index
    has_scope :with_user,         only: :index
    has_scope :with_customer,     only: :index
    has_scope :with_process,      only: :index
    has_scope :with_part,         only: :index
    has_scope :with_rework,       only: :index

    def index
      @bbl = apply_scopes(@blocks = Thickness::Block.all).includes(:checks).page(params[:page]).order('updated_at DESC')
      respond_to do |format|
        format.html
        format.json { render :json => @blocks }
        format.xlsx
      end
    end
  
    def show
      respond_to do |format|
        format.html
        format.json { render :json => @block }
      end
    end
  
    def new
      @block = Block.new(block_params) 
      @checks = @block.checks.build
    end
  
    def edit
    end
  
    def create
      @block = Block.new(block_params) 
      @checks = @block.checks.build
      if @block.save
        remove_blank_checks(@block)
        flash[:success] = "Block created."
        respond_to do |format|
          format.html { redirect_to block_path(@block)}
          format.json { render :json => @block }
        end
      else
        render :action => 'new'
        Rails.logger.info(@block.errors.inspect)
      end 
    end
  
    def update
      if @block.update(block_params)
        flash[:success] = "Block updated."
        redirect_to block_path(@block)
      else
        render 'edit'
      end
    end
  
    def destroy
      @block.destroy
      respond_to do |format|
        format.html { redirect_to blocks_url, notice: 'Block was successfully destroyed.' }
        format.json { head :no_content }
      end
    end

    private
      # Select Block by id.
      def set_block
        @block = Block.find(params[:id])
      end
  
      # Never trust parameters from the internet, only allow the white list.
      def block_params
         params.require(:block).permit( 
           :user_id, :so_num, :load_num, :block_num, :is_rework, :directory, :product, :application, :customer, :process,  :part, :sub, :load_weight, :piece_weight, :part_area, :part_density, 
           :checks_attributes => [:id, :check_timestamp, :check_num, :thickness, :alloy_percentage, :x, :y, :z, '_destroy'])
      end 

      def remove_blank_checks(block)
        block.checks.each do |c|
          if c.thickness.blank?
            c.destroy
          end
        end
      end  
  end
end