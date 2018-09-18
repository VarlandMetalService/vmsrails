module Timeclock
  class Timeclock::ClockRecordsController < ApplicationController
    before_action :set_clock_record, only: [:show, :edit, :update, :destroy]

    def index
      @clock_records = Timeclock::ClockRecord.all
      @clock_record = Timeclock::ClockRecord.new
      @clock_edit = @clock_record.build_clock_edit
      respond_to do |format|
        format.html
        format.json { render :json => @clock_records }
      end
    end

    def show
    end

    def new
      @clock_record = ClockRecord.new
    end

    def edit
      @clock_edit = @clock_record.build_clock_edit
    end

    def create
      @clock_record = ClockRecord.new(clock_record_params)
      @clock_record.record_type = params["record_type"] unless params["record_type"].blank?
      round_minutes(@clock_record)
      if(ClockRecord.all.where(@current_user.id == :user_id).exists? &&@clock_record.timestamp == ClockRecord.all.where(@current_user.id == :user_id).last.timestamp)
        @clock_record.timestamp += 1.minute
      end
      set_or_create_period(@clock_record)
      if @clock_record.save
        flash[:success] = "Clock record created."
        respond_to do |format|
          format.html { redirect_back(fallback_location: '') }
          format.json { render :json => @clock_record }
        end
      else
        render :action => 'new'
        Rails.logger.info(@clock_record.errors.inspect)
      end 
    end

    def update
        if @clock_record.update(clock_record_params)
          @clock_record.save
          flash[:success] = "Clock record updated."
          redirect_to timeclock_clock_record_path(@clock_record)
        else
          render 'edit'
        end
    end

    def destroy
      @clock_record.destroy
      respond_to do |format|
        format.html { redirect_back(fallback_location: '') }
        format.json { head :no_content }
      end
    end

    def holiday_hours
      recs = []
      params[:timeclock_clock_period][:users].each do |u|
        rec = Timeclock::ClockRecord.new(:user_id => u, :record_type => 'Holiday', :timestamp => params[:timeclock_clock_period][:start_date])
        rec.save
        recs << rec
      end
      recs.each do |c|
        set_or_create_period(c)
      end
      respond_to do |format|
        format.html { redirect_back(fallback_location: '') }
        format.json { head :no_content }
      end
    end
    private
      # Select shift note by id.
      def set_clock_record
        @clock_record = ClockRecord.find(params[:id])
      end

      # Never trust parameters from the internet, only allow the white list.
      def clock_record_params
        params.require(:timeclock_clock_record).permit(:id, :user_id,:record_type, :ip_address, :deleted_at, :timestamp, clock_edit_attributes: [:id, :clock_record_id, :user_id, :ip_address, :reason_id, :deleted_at, :note] )
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

  end
end