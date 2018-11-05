class Timeclock::ClockPeriodsController < ApplicationController
  before_action :set_clock_period, only: [ :edit, :update, :destroy]

  def index
    @timeclock_clock_periods = Timeclock::ClockPeriod.includes( { clock_records: [:clock_edit, :user]} )
  end

  def show
    @timeclock_clock_period = Timeclock::ClockPeriod.includes( :clock_records, { clock_records: [:clock_edit, :user]} ).find(params[:id])
  end

  def new
    @timeclock_clock_period = Timeclock::ClockPeriod.new
  end

  def edit
  end

  def create
    @timeclock_clock_period = Timeclock::ClockPeriod.new(timeclock_clock_period_params)

    respond_to do |format|
      if @timeclock_clock_period.save
        format.html { redirect_to @timeclock_clock_period, notice: 'Clock period was successfully created.' }
        format.json { render :show, status: :created, location: @timeclock_clock_period }
      else
        format.html { render :new }
        format.json { render json: @timeclock_clock_period.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @timeclock_clock_period.update(timeclock_clock_period_params)
        format.html { redirect_to @timeclock_clock_period, notice: 'Clock period was successfully updated.' }
        format.json { render :show, status: :ok, location: @timeclock_clock_period }
      else
        format.html { render :edit }
        format.json { render json: @timeclock_clock_period.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @timeclock_clock_period.destroy
    respond_to do |format|
      format.html { redirect_to timeclock_clock_periods_url, notice: 'Clock period was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_clock_period
      @timeclock_clock_period = Timeclock::ClockPeriod.find(params[:id])
    end
    
    def timeclock_clock_period_params
      params.require(:timeclock_clock_period).permit(:finalized)
    end
end
