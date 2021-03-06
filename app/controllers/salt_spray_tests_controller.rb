class SaltSprayTestsController < ApplicationController
  include ApplicationHelper
  before_action :set_salt_spray_test,   only: [:show, :edit, :update, :destroy, :finalized]
  before_action :detect_device_variant, only: :index
  has_scope :with_process_code,         only: :index

  # Notes: If spec is > 24 hours, measure in days (24 hour periods), display hours

  def index 
    check_permission('salt_spray_tests')
    manage_filter_state
    if params[:with_deleted]
      @salt_spray_tests = apply_scopes(SaltSprayTest.with_deleted).includes( :salt_spray_test_checks, :comments, :user).order("salt_spray_test_checks.date asc")
    else
      @salt_spray_tests = apply_scopes(SaltSprayTest).includes( :salt_spray_test_checks, :comments).order("salt_spray_test_checks.date asc")
    end
    if params[:recently]
    else
      @salt_spray_tests = @salt_spray_tests.not_recently
    end
    @user_filter = User.pluck(:first_name, :last_name, :suffix, :id).uniq.map { |f,l,s,i| ["#{f} #{l} #{s}", i]}
    @check = SaltSprayTestCheck.new
    respond_to do |format|
      format.html
      format.html.mobile render layout: "mobile"
      format.json { render :json => @salt_spray_tests }
    end
  end

  def show
    @commentable = @salt_spray_test
    SaltSprayTestMailer.send_test(@salt_spray_test).deliver_later
  end

  def new
    @salt_spray_test = SaltSprayTest.new
    @check = @salt_spray_test.salt_spray_test_checks.build
  end

  def edit
    @user_filter = User.pluck(:first_name, :last_name, :suffix, :id).uniq.map { |f,l,s,i| ["#{f} #{l} #{s}", i]}
  end

  def create
    @salt_spray_test = SaltSprayTest.new(salt_spray_test_params)
    if @salt_spray_test.save
      if SaltSprayTest::call_api(@salt_spray_test)
        respond_to do |format|
          flash[:success] = "Salt spray test created."
          format.html { redirect_to salt_spray_tests_path }
          format.json { render :json => @salt_spray_test }
        end
      else
        flash[:warning] = "Shop order not found in system."
        respond_to do |format|
          format.html { redirect_to edit_salt_spray_test_path(@salt_spray_test)}
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

  def destroy
    @salt_spray_test.destroy
    respond_to do |format|
      flash[:danger] = 'Salt spray test destroyed.'
      format.html { redirect_to salt_spray_tests_path }
      format.json { head :no_content }
    end
  end

  def send_test
    if params[:email_sales]
      SaltSprayTestMailer.send_test(SaltSprayTest.find(params[:email_sales]), "Sales <richard.legacy@varland.com>").deliver_later
      params.delete :email_sales
      flash[:success] = 'Email sent.'
    end
    if params[:email_management]
      SaltSprayTestMailer.send_test(SaltSprayTest.find(params[:email_management]), "Management <richard.legacy@varland.com>").deliver_later
      params.delete :email_management
      flash[:success] = 'Email sent.'
    end
    respond_to do |format|
      format.html { redirect_to salt_spray_tests_path }
    end
  end

  def finalized
    @check = @salt_spray_test.salt_spray_test_checks.build
  end

  private
    # Select Salt spray test by id.
    def set_salt_spray_test
      @salt_spray_test = SaltSprayTest.with_deleted.find(params[:id])
    end

    # Never trust parameters from the internet, only allow the white list.
    # { :process => [] }
    def salt_spray_test_params
      params.require(:salt_spray_test).permit(:so_num, :load_num, :user_id, :process_code, :load_weight, :customer, :dept, :part_tag, :sub_tag, :part_area, :part_density, :white_spec, :red_spec, :deleted_at, :is_sample, :sample_code, { :salt_spray_test_checks_attributes => [:id, :salt_spray_test_id, :c_type, :date, :user_id, :test_id] }, { :salt_spray_test_check => [:id, :salt_spray_test_id, :c_type, :date, :user_id, :test_id] }, { :process => []} )
    end

    def detect_device_variant
      request.variant = :mobile if browser.device.mobile? ||                                               browser.device.tablet?
    end

    def manage_filter_state
      if params[:reset]
        cookies[:with_user] = ""
        cookies[:with_process_code] = ""
      else
        if params[:with_user]
          cookies[:with_user] = { value: params[:with_user], expires: 1.day.from_now }
        else
          if cookies[:with_user]
            params[:with_user] = cookies[:with_user]
          end
        end
        if params[:with_process_code]
          cookies[:with_process_code] = { value: params[:with_process_code], expires: 1.day.from_now }
        else
          if cookies[:with_process_code]
            params[:with_process_code] = cookies[:with_process_code]
          end
        end
      end
    end
end

