class TimeclockController < ApplicationController
  helper Timeclock::ReasonCodesHelper
  skip_before_action  :authenticate_user, only: [:login, :on_clock]
  before_action :detect_device_variant, only: :punch

  def login
    remove_nav
    if @current_user.blank?
    else
      redirect_to timeclock_url
    end
  end

  def punch
    if browser.device.tablet?
      remove_nav
    end
    @clock_record = Timeclock::ClockRecord.new(user_id: @current_user.id)
  # need to start sunday at 7am and end sunday at 6:59 apparently three (...) is open at start and closed at end, we will see
    @period_records = @current_user.clock_records.where(timestamp: (DateTime.now - DateTime.now.wday).change(hour: 7)...(DateTime.now - DateTime.now.wday + 7).change(hour: 7)).includes(:clock_edit).order('timestamp')
    respond_to do |format|
      format.html
      format.html.mobile render layout: "mobile"
    end
  end

  def detect_device_variant
    request.variant = :mobile if browser.device.mobile? ||                                               browser.device.tablet?
  end

  def on_clock
    @users = User.where(is_clockedin: :true)
    @groups = [["Plating", 0, 199], ["Maintenance", 200, 299], ["Lab", 300, 399], ["Shipping/QC", 400, 499], ["Office", 800, 899]]
  end

  def update_pin
    @user = @current_user
    if @user.pin.to_i == params[:update_pin][:pin].to_i && @user.pin.to_i == params[:update_pin][:pin2].to_i
      @user.update_attribute(:pin, params[:update_pin][:new_pin])
      flash[:success] = "PIN updated."
    else
      flash[:danger] = "Failed to update PIN."
    end
    respond_to do |format|
      format.html { redirect_back(fallback_location: timeclock_path) }
    end
  end
end
