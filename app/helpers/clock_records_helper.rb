module ClockRecordsHelper

  def records_to_weeks(period_records)
    sun_rec = [] 
    mon_rec = [] 
    tue_rec = [] 
    wed_rec = [] 
    thu_rec = [] 
    fri_rec = [] 
    sat_rec = []
    period_records.sort_by{ |key| key[:timestamp]} 
    period_records.reverse
    period_records.each do |record|
      case record.timestamp.strftime("%A")
        when 'Sunday'
          if record.timestamp.strftime("%H").to_i < 7
            sat_rec << record
          else
            sun_rec << record
          end
        when'Monday'
          if record.timestamp.strftime("%H").to_i < 7
            sun_rec << record
          else
            mon_rec << record
          end
        when 'Tuesday'
          if record.timestamp.strftime("%H").to_i < 7
            mon_rec << record
          else
            tue_rec << record
          end    
        when 'Wednesday'
          if record.timestamp.strftime("%H").to_i < 7
            tue_rec << record
          else
            wed_rec << record
          end   
        when 'Thursday'
          if record.timestamp.strftime("%H").to_i < 7
            wed_rec << record
          else
            thu_rec << record
          end     
        when 'Friday'
          if record.timestamp.strftime("%H").to_i < 7
            thu_rec << record
          else
            fri_rec << record
          end
        when 'Saturday'
          if record.timestamp.strftime("%H").to_i < 7
            fri_rec << record
          else
            sat_rec << record
          end
      end
    end
    week_rec = [sun_rec, mon_rec, tue_rec, wed_rec, thu_rec, fri_rec, sat_rec]
    return week_rec
  end

  def seconds_since_day_start(time)
    if time.seconds_since_midnight < 7*3600
      return time.seconds_since_midnight + 17*3600
    else
      return time.seconds_since_midnight - 7*3600
    end
  end

  def calc_week_totals(week_rec)
    # seconds per hour
    sph = 3600
    start = nil
    week_totals = []
    
    week_rec.each do |day|
      total = 0

      day.each_with_index do |rec, i|

        if rec.record_type == 'Holiday'
          total += 8*3600
        end
        if rec.record_type == 'Start Work' || rec.record_type == 'End Break'
          total -= seconds_since_day_start(rec.timestamp)
        end
        if rec.record_type == 'End Work' || rec.record_type == 'Start Break'
          total += seconds_since_day_start(rec.timestamp)
        end   

        if i == day.size - 1
          if rec.record_type == 'Start Work' || rec.record_type == 'End Break'
            total += 24*3600
          elsif rec.record_type == 'Start Break'
            total -= 24*3600
          end
        end
      end
    if total < 0
      total += 24*3600
    end
    total/3600
    week_totals << ((4*total/3600).round / 4.0)
    end
    return week_totals
  end
  


end
