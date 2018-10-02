class SaltSprayTestsController < ApplicationController
  include ApplicationHelper
  before_action :set_salt_spray_test, only: [:show, :edit, :update, :destroy]


  def index 
    @salt_spray_tests = apply_scopes(SaltSprayTest).all.page(params[:page])
    respond_to do |format|
      format.html
      format.json { render :json => @salt_spray_tests }
    end
  end

  def show
    @commentable = @rejected_part
  end

  def new
    @salt_spray_test = SaltSprayTest.new
  end

  def edit
  end

  def create
    @salt_spray_test = SaltSprayTest.new(salt_spray_test_params) 
    if @salt_spray_test.save
      flash[:success] = "Salt spray test created."
      respond_to do |format|
        format.html { redirect_to salt_spray_test_path(@salt_spray_test)}
        format.json { render :json => @salt_spray_test }
      end
    else
      render :action => 'new'
      Rails.logger.info(@salt_spray_test.errors.inspect)
    end 
  end

  def update
      if @salt_spray_test.update(salt_spray_test_params)
        flash[:success] = "Salt spray test updated."
        redirect_to salt_spray_test_path(@salt_spray_test)
      else
        render 'edit'
      end
  end

  def destroy
    @salt_spray_test.destroy
    respond_to do |format|
      format.html { redirect_to salt_spray_tests_url, notice: 'Salt spray test was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Select Salt spray test by id.
    def set_salt_spray_test
      @salt_spray_test = SaltSprayTest.find(params[:id])
    end

    # Never trust parameters from the internet, only allow the white list.
    def salt_spray_test_params
      params.require(:salt_spray_test).permit(:so_num, :load_num, :custoemr, :process_code, :part_num, :sub, :part_area, :density, :white_spec, :red_spec, :dept, :load_weight, :on_by, :on_at, :off_by, :off_at, :white_by, :white_at, :red_by, :red_at, :flagged_by)
    end

end

