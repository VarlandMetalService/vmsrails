class ShopOrderFilesController < ApplicationController

before_action :set_shop_order_file, only: [:show, :edit, :update, :destroy]
skip_before_action :authenticate_user
skip_before_action :verify_authenticity_token

has_scope :with_so_num,    only: :index

def index
  @shop_order_files = apply_scopes(ShopOrderFile.all.order('so_num desc'))
  respond_to do |format|
    format.html
    format.json { render :json => @shop_order_files }
  end
end

def show
end

def new
  @shop_order_file = ShopOrderFile.new() 
end

def edit
end

def create
  @shop_order_file = ShopOrderFile.new(shop_order_file_params) 
  if @shop_order_file.save
    flash[:success] = "File created."
    respond_to do |format|
      format.html { redirect_to shop_order_files_path}
      format.json { render :json => @shop_order_file }
    end
  else
    render :action => 'new'
  end 
end

def update
  if @shop_order_file.update(shop_order_file_params)
    flash[:success] = "shop_order_file updated."
    redirect_to shop_order_file_path(@shop_order_file)
  else
    render 'edit'
  end
end

def destroy
  @shop_order_file.destroy
  respond_to do |format|
    format.html { redirect_to shop_order_files_url, notice: 'shop_order_file was successfully destroyed.' }
    format.json { head :no_content }
  end
end

private
  # Select shop_order_file by id.
  def set_shop_order_file
    @shop_order_file = ShopOrderFile.find(params[:id])
  end

  # Never trust parameters from the internet, only allow the white list.
  def shop_order_file_params
      params.require(:shop_order_file).permit(:file, :so_num)
  end 
end
