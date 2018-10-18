class SaltSprayTestChecksController < ApplicationController
  include ApplicationHelper
  before_action :set_salt_spray_test_check, only: [:show, :edit, :update, :destroy]

  # Notes: If spec is > 24 hours, measure in days (24 hour periods), display hours
  # Need a mobile interface to mark tests On, OK, White, Red, Off 
  # Cards, scrollable, toby's design

  def index 
    @salt_spray_test_check = SaltSprayTestCheck.new(salt_spray_test_check_params)
    if @salt_spray_test_check.save
      flash[:success] = "Check created."
      respond_to do |format|
        format.html { redirect_to salt_spray_tests_path}
        format.json { render :json => @salt_spray_test }
      end
    else
      render :action => 'new'
      Rails.logger.info(@salt_spray_test.errors.inspect)
    end 
  end

  def show
  end

  def new
    @salt_spray_test_check = SaltSprayTestCheck.new
  end

  def edit
  end

  def create
    if params[:salt_spray_test_check][:c_type] == 'OFF'
      SaltSprayTest.with_deleted.find(params[:salt_spray_test_id]).update_attribute(:deleted_at, Time.now )
    end
    @salt_spray_test_check = SaltSprayTestCheck.new(salt_spray_test_check_params)
    @salt_spray_test_check.salt_spray_test = SaltSprayTest.with_deleted.find(params[:salt_spray_test_id])
    if @salt_spray_test_check.save
      flash[:success] = "Check created."
      respond_to do |format|
        format.js {render inline: "location.reload();" }
        format.html { redirect_to salt_spray_tests_path}
        format.json { render :json => @salt_spray_test }
      end
    else
      render :action => 'new'
      Rails.logger.info(@salt_spray_test.errors.inspect)
    end 
  end

  def update
      if @salt_spray_test_check.update(salt_spray_test_check_params)
        flash[:success] = "Check updated."
        redirect_to salt_spray_tests_path
      else
        render 'edit'
      end
  end

  def destroy
    @salt_spray_test_check.destroy
    respond_to do |format|
      format.html { redirect_to salt_spray_tests_url, notice: 'Salt spray check was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Select Salt spray test by id.
    def set_salt_spray_test_check
      @salt_spray_test_check = SaltSprayTestCheck.find(params[:id])
    end

    # Never trust parameters from the internet, only allow the white list.
    def salt_spray_test_check_params
      params.require(:salt_spray_test_check).permit( :id, :c_type, :date, :user_id, :salt_spray_test_id )
    end

end

