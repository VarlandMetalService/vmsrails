module Timeclock
  class Timeclock::ClockRecordsController < ApplicationController
    before_action :set_clock_record, only: [:show, :edit, :update, :destroy]

    def index
      @clock_records = Timeclock::ClockRecord.all.includes(:user, :reason_code)
      @clock_record = Timeclock::ClockRecord.new
      @clock_edit = @clock_record.build_clock_edit
      respond_to do |format|
        format.html
        format.json { render :json => @clock_records }
      end
    end

    def new
      @clock_record = ClockRecord.new
    end

    def edit
      @clock_edit = @clock_record.build_clock_edit
    end

    def create
      if !params[:timeclock_clock_record][:user_id][2].blank?
        params[:timeclock_clock_record][:user_id].each do |user|
          if user == ""
          else
          @clock_record = ClockRecord.new(
            :timestamp => params[:timeclock_clock_record][:timestamp],
            :record_type => params[:timeclock_clock_record][:record_type],
            :user_id => user)
            helpers.round_minutes(@clock_record)
            helpers.set_or_create_period(@clock_record)
            @clock_record.save
          end
        end
        flash[:success] = "#{params[:timeclock_clock_record][:user_id].count - 1 } Holiday Records created!"
        respond_to do |format|
          format.html { redirect_back(fallback_location: "")}
        end
      else
        @clock_record = ClockRecord.new(clock_record_params)
        @clock_record.record_type = params["record_type"] unless params["record_type"].blank?
        helpers.round_minutes(@clock_record)
        helpers.set_or_create_period(@clock_record)
        if @clock_record.save
          flash[:success] = "Clock record created."
          if @clock_record.record_type == "Start Work"
            @clock_record.user.update_attribute(:is_clockedin, true)
          elsif @clock_record.record_type == "End Work"
            @clock_record.user.update_attribute(:is_clockedin, false)
          end
          respond_to do |format|
            format.html { redirect_back(fallback_location: '') }
            format.json { render :json => @clock_record }
          end
        else
          render :action => 'new'
          Rails.logger.info(@clock_record.errors.inspect)
        end 
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
      flash[:danger] = "Record destroyed."
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
        helpers.set_or_create_period(c)
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

  end
end