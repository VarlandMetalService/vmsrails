class Timeclock::ClockPeriodsController < ApplicationController
  before_action :set_clock_period, only: [ :edit, :update, :destroy]

  # GET /timeclock/clock_periods
  # GET /timeclock/clock_periods.json
  def index
    @timeclock_clock_periods = Timeclock::ClockPeriod.all
  end

  # GET /timeclock/clock_periods/1
  # GET /timeclock/clock_periods/1.json
  def show
    @timeclock_clock_period = Timeclock::ClockPeriod.find(params[:id])
  end

  # GET /timeclock/clock_periods/new
  def new
    @timeclock_clock_period = Timeclock::ClockPeriod.new
  end

  # GET /timeclock/clock_periods/1/edit
  def edit
  end

  # POST /timeclock/clock_periods
  # POST /timeclock/clock_periods.json
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

  # PATCH/PUT /timeclock/clock_periods/1
  # PATCH/PUT /timeclock/clock_periods/1.json
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

  # DELETE /timeclock/clock_periods/1
  # DELETE /timeclock/clock_periods/1.json
  def destroy
    @timeclock_clock_period.destroy
    respond_to do |format|
      format.html { redirect_to timeclock_clock_periods_url, notice: 'Clock period was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_clock_period
      @timeclock_clock_period = Timeclock::ClockPeriod.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def timeclock_clock_period_params
      params.require(:timeclock_clock_period).permit(:finalized)
    end
end
