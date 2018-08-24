class TimeclockController < ApplicationController
  helper Timeclock::ReasonCodesHelper
  skip_before_action  :authenticate_user, only: [:login]

  def work
    @clock_record = Timeclock::ClockRecord.new(user_id: @current_user.id)
    # need to start sunday at 7am and end sunday at 6:59 apparently three (...) is open at start and closed at end, we will see
    @period_records = Timeclock::ClockRecord.where(timestamp: (DateTime.now - DateTime.now.wday).change(hour: 7)...(DateTime.now - DateTime.now.wday + 7).change(hour: 7)).where(user_id: @current_user.id).includes(:clock_edit).order('timestamp')
    end

    def login
      if @current_user.blank?
      else
        redirect_to timeclock_url
      end
    end
end
