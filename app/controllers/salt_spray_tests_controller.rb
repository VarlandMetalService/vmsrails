class SaltSprayTestsController < ApplicationController
  include ApplicationHelper
  before_action :set_salt_spray_test, only: [:show, :edit, :update, :destroy]

  # Notes: If spec is > 24 hours, measure in days (24 hour periods), display hours
  # Need a mobile interface to mark tests On, OK, White, Red, Off 
  # Cards, scrollable, toby's design

  has_scope :with_process_code,     only: :index

  def index 
    @salt_spray_tests = apply_scopes(SaltSprayTest).all.page(params[:page]).includes(:comments, :salt_spray_test_checks)
    @check = SaltSprayTestCheck.new
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
    @check = @salt_spray_test.checks.build
  end

  def edit
  end

  def create
    @salt_spray_test = SaltSprayTest.new(salt_spray_test_params)
    @check = @salt_spray_test.checks.build
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
        redirect_to salt_spray_tests_path
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
      params.require(:salt_spray_test).permit(:so_num, :load_num, :user_id, :process_code, :load_weight, :customer, :dept, :part_tag, :sub_tag, :part_area, :part_density, :white_spec, :red_spec, { :checks_attributes => [:salt_spray_test_id, :c_type, :date, :user_id, :test_id] }, { :process => [] } )
    end

end

