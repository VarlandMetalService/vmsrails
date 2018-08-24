module Timeclock
  class Timeclock::ReasonCodesController < ApplicationController
    before_action :set_reason_code, only: [:show, :edit, :update, :destroy]

    # GET /timeclock/reason_codes
    # GET /timeclock/reason_codes.json
    def index
      @reason_codes = Timeclock::ReasonCode.all
    end

    # GET /timeclock/reason_codes/1
    # GET /timeclock/reason_codes/1.json
    def show
    end

    # GET /timeclock/reason_codes/new
    def new
      @reason_code = Timeclock::ReasonCode.new
    end

    # GET /timeclock/reason_codes/1/edit
    def edit
    end

    # POST /timeclock/reason_codes
    # POST /timeclock/reason_codes.json
    def create
      @reason_code = Timeclock::ReasonCode.new(reason_code_params)

      respond_to do |format|
        if @reason_code.save
          format.html { redirect_to @reason_code, notice: 'Reason code was successfully created.' }
          format.json { render :show, status: :created, location: @reason_code }
        else
          format.html { render :new }
          format.json { render json: @reason_code.errors, status: :unprocessable_entity }
        end
      end
    end

    # PATCH/PUT /timeclock/reason_codes/1
    # PATCH/PUT /timeclock/reason_codes/1.json
    def update
      respond_to do |format|
        if @reason_code.update(reason_code_params)
          format.html { redirect_to @reason_code, notice: 'Reason code was successfully updated.' }
          format.json { render :show, status: :ok, location: @reason_code }
        else
          format.html { render :edit }
          format.json { render json: @timeclock_reason_code.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /timeclock/reason_codes/1
    # DELETE /timeclock/reason_codes/1.json
    def destroy
      @timeclock_reason_code.destroy
      respond_to do |format|
        format.html { redirect_to timeclock_reason_codes_url, notice: 'Reason code was successfully destroyed.' }
        format.json { head :no_content }
      end
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_timeclock_reason_code
        @timeclock_reason_code = Timeclock::ReasonCode.find(params[:id])
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def timeclock_reason_code_params
        params.require(:timeclock_reason_code).permit(:description, :requires_note)
      end
  end
end
