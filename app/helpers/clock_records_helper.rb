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
    @week_rec ||= [sun_rec, mon_rec, tue_rec, wed_rec, thu_rec, fri_rec, sat_rec]
    return @week_rec
  end

  def calc_week_totals(week_rec)
    week_totals ||= []

    week_rec.each do |day_rec|
      total = 0
      prev_rec = nil

      day_rec.each do |rec|

        if prev_rec == nil
          if rec.record_type == 'End Work' || rec.record_type == 'Start Break'
            total -= 7*3600
          elsif rec.record_type == 'End Break'
            total += 7*3600
          end
        end

        if rec.record_type == 'Start Work' || rec.record_type == 'End Break'
          total -= rec.timestamp.seconds_since_midnight
        elsif rec.record_type == 'End Work' || rec.record_type == 'Start Break'
          total += rec.timestamp.seconds_since_midnight
        end

        if prev_rec != nil && prev_rec.timestamp.strftime("%A") != rec.timestamp.strftime("%A")
          if rec.record_type =='End Break'
            total += (24*3600)
          elsif rec.record_type == 'Start Break'
            total -= (24*3600)
          end
        end

        if day_rec.last == rec
          if rec.record_type == 'Start Work' || rec.record_type == 'End Break'
            total += 7*3600
            if rec.timestamp.strftime("%A") == day_rec.first.timestamp.strftime("%A")
              total += (23*3600 + 59*60 + 59)
            end
          end
        end
        prev_rec = rec
      end
      week_totals << total/3600
    end
    return week_totals
  end


end
