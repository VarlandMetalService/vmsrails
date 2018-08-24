class TimeclockController < ApplicationController
  helper Timeclock::ReasonCodesHelper

  def work
    @clock_record = Timeclock::ClockRecord.new(user_id: @current_user.id)
    @period_records = Timeclock::ClockRecord.includes(:clock_edit).where(timestamp: (Date.today - DateTime.now.wday)..(Date.today - DateTime.now.wday + 7)).order('timestamp')
  end
end
