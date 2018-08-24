module ClockRecordsHelper

  def records_to_weeks(period_records)
    sun_rec ||= [] 
    mon_rec ||= [] 
    tue_rec ||= [] 
    wed_rec ||= [] 
    thu_rec ||= [] 
    fri_rec ||= [] 
    sat_rec ||= [] 
    period_records.each do |record|
      if record.timestamp.strftime("%A") == 'Sunday'
        sun_rec << record
      end
      if record.timestamp.strftime("%A") == 'Monday'
        mon_rec << record
      end
      if record.timestamp.strftime("%A") == 'Tuesday'
        tue_rec << record
      end
      if record.timestamp.strftime("%A") == 'Wednesday'
        wed_rec << record
      end
      if record.timestamp.strftime("%A") == 'Thursday'
        thu_rec << record
      end
      if record.timestamp.strftime("%A") == 'Friday'
        fri_rec << record
      end
      if record.timestamp.strftime("%A") == 'Saturday'
        sat_rec << record
      end
    end
    @week_rec ||= [sun_rec, mon_rec, tue_rec, wed_rec, thu_rec, fri_rec, sat_rec]
    return @week_rec
  end

  def calc_week_totals(week_rec)
    week_totals ||= []
    week_rec.each do |day|
      total = 0
      day.each do |rec|
        if rec.record_type == 'End Work' || rec.record_type == 'Start Break'
          total += rec.timestamp.to_i
        else
          total -= rec.timestamp.to_i
        end
      end
      week_totals << total/3600
    end
    return week_totals
  end


end
