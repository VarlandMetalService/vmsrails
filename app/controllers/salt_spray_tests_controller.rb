class SaltSprayTestsController < ApplicationController
  include ApplicationHelper
  before_action :set_salt_spray_test, only: [:show, :edit, :update, :destroy]
  before_action :detect_device_variant, only: :index

  # Notes: If spec is > 24 hours, measure in days (24 hour periods), display hours

  has_scope :with_process_code,     only: :index

  def index 
    if params[:with_deleted]
      @salt_spray_tests = apply_scopes(SaltSprayTest.with_deleted).all.includes( :salt_spray_test_checks, :comments).order("salt_spray_test_checks.date asc")
    else
    @salt_spray_tests = apply_scopes(SaltSprayTest).all.includes( :salt_spray_test_checks, :comments).order("salt_spray_test_checks.date asc").not_recently
    end
    @check = SaltSprayTestCheck.new
    respond_to do |format|
      format.html
      format.html.mobile 
      format.json { render :json => @salt_spray_tests }
    end
  end

  def show
    @commentable = @salt_spray_test
  end

  def new
    @salt_spray_test = SaltSprayTest.new
    @check = @salt_spray_test.salt_spray_test_checks.build
  end

  def edit
  end

  def create
    @salt_spray_test = SaltSprayTest.new(salt_spray_test_params)
    if @salt_spray_test.save
      if call_api(@salt_spray_test.so_num)
        respond_to do |format|
          format.html { redirect_to salt_spray_tests_path }
          format.json { render :json => @salt_spray_test }
        end
      else
        respond_to do |format|
          format.html { redirect_to edit_salt_spray_test_path(@salt_spray_test) }
          format.json { render :json => @salt_spray_test }
        end
      end
    else
      render :action => 'new'
      Rails.logger.info(@salt_spray_test.errors.inspect)
    end 
  end

  def update
    @check = SaltSprayTestCheck.new
    if @salt_spray_test.update(salt_spray_test_params)
      flash[:success] = "Salt spray test updated."
      redirect_to salt_spray_tests_path
    else
      render 'edit'
    end
  end

  def manual_entry
    @salt_spray_test = SaltSprayTest.find(params[:format])
    if @salt_spray_test.update(salt_spray_test_params)
      flash[:success] = "Salt spray test updated."
    end
  end

  def destroy
    @salt_spray_test.destroy
    respond_to do |format|
      format.html { redirect_to salt_spray_tests_path, notice: 'Salt spray test was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Select Salt spray test by id.
    def set_salt_spray_test
      @salt_spray_test = SaltSprayTest.find(params[:id])
    end

    # Never trust parameters from the internet, only allow the white list.
    # { :process => [] }
    def salt_spray_test_params
      params.require(:salt_spray_test).permit(:so_num, :load_num, :user_id, :process_code, :load_weight, :customer, :dept, :part_tag, :sub_tag, :part_area, :part_density, :white_spec, :red_spec, :deleted_at, { :salt_spray_test_checks_attributes => [:salt_spray_test_id, :c_type, :date, :user_id, :test_id] }, { :salt_spray_test_check => [:salt_spray_test_id, :c_type, :date, :user_id, :test_id] } )
    end

    def detect_device_variant
      request.variant = :mobile if browser.device.mobile? ||                                               browser.device.tablet?
    end

    def call_api(so_num)
      return false
    end
end

