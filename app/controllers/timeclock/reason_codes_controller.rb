module Timeclock
  class Timeclock::ReasonCodesController < ApplicationController
    before_action :set_timeclock_reason_code, only: [:show, :edit, :update, :destroy]

    def index
      @reason_codes = Timeclock::ReasonCode.all
    end

    def show
    end

    def new
      @reason_code = Timeclock::ReasonCode.new
    end

    def edit
    end

    def create
      @reason_code = Timeclock::ReasonCode.new(timeclock_reason_code_params)
      respond_to do |format|
        if @reason_code.save
          flash[:success] = "Reason code created."
          format.html { redirect_to timeclock_reason_codes_path }
          format.json { render :show, status: :created, location: @reason_code }
        else
          format.html { render :new }
          format.json { render json: @reason_code.errors, status: :unprocessable_entity }
        end
      end
    end

    def update
      respond_to do |format|
        if @reason_code.update(timeclock_reason_code_params)
          format.html { redirect_to @reason_code, notice: 'Reason code was successfully updated.' }
          format.json { render :show, status: :ok, location: @reason_code }
        else
          format.html { render :edit }
          format.json { render json: @timeclock_reason_code.errors, status: :unprocessable_entity }
        end
      end
    end

    def destroy
      @timeclock_reason_code.destroy
      respond_to do |format|
        format.html { redirect_to timeclock_reason_codes_url, notice: 'Reason code was successfully destroyed.' }
        format.json { head :no_content }
      end
    end

    private
      def set_timeclock_reason_code
        @timeclock_reason_code = Timeclock::ReasonCode.find(params[:id])
      end

      def timeclock_reason_code_params
        params.require(:timeclock_reason_code).permit(:description)
      end
  end
end
