module Timeclock::ClockRecordsHelper

  def round_minutes(cr)
    if cr.record_type == 'Start Work'
      if(cr.timestamp.min <= 3)
        cr.timestamp = cr.timestamp.change(min: 0)
      elsif cr.timestamp.min <= 18
        cr.timestamp = cr.timestamp.change(min: 15)
      elsif cr.timestamp.min <= 33
        cr.timestamp = cr.timestamp.change(min: 30)
      elsif cr.timestamp.min <= 48
        cr.timestamp = cr.timestamp.change(min: 45)
      else
        cr.timestamp = cr.timestamp.advance(hours: +1)
        cr.timestamp = cr.timestamp.change(min: 0)
      end 
    elsif cr.record_type == 'End Work' ||
          cr.record_type == 'End Break'||
          cr.record_type == 'Start Break'
     if(cr.timestamp.min < 14)
       cr.timestamp = cr.timestamp.change(min: 0)
     elsif cr.timestamp.min < 29
       cr.timestamp = cr.timestamp.change(min: 15)
     elsif cr.timestamp.min < 44
       cr.timestamp = cr.timestamp.change(min: 30)
     elsif cr.timestamp.min < 59
       cr.timestamp = cr.timestamp.change(min: 45)
     end 
    end
  end

  def set_or_create_period(cr)
    Timeclock::ClockPeriod.all.where(:finalized => false).each do |period|
      if (period.start_date...period.end_date).cover?(cr.timestamp)
        cr.update_attribute(:clock_period_id, period.id)
      end
    end
    if cr.clock_period_id.blank?
      sun = cr.timestamp.beginning_of_day - cr.timestamp.wday.days
      period = Timeclock::ClockPeriod.create(                            :start_date => (sun + 7.hours), :end_date => (sun + 6.days + 7.hours),
        :finalized => false )
        cr.update_attribute(:clock_period_id, period.id)
    end
  end
end