module Timeclock
  class ClockEditsController < ApplicationController
    before_action :set_clock_edit, only: [:show, :edit, :update, :destroy]

    # GET /clock_edits
    # GET /clock_edits.json
    def index
      @clock_edits = ClockEdit.all
    end

    # GET /clock_edits/1
    # GET /clock_edits/1.json
    def show
    end

    # GET /clock_edits/new
    def new
      @clock_edit = ClockEdit.new
      @clock_edit.clock_record = ClockRecord.find(params["rid"])
    end

    # GET /clock_edits/1/edit
    def edit
      @clock_edit.clock_record = ClockRecord.find(@clock_edit.clock_record_id)
    end

    # POST /clock_edits
    # POST /clock_edits.json
    def create
      @clock_edit = ClockEdit.new(clock_edit_params)
      respond_to do |format|
        if @clock_edit.save
          @clock_edit.clock_record.update_attributes(:record_type => params["timeclock_clock_edit"]["clock_record_record_type"], :timestamp => params["timeclock_clock_edit"]["clock_record_timestamp"] )
          format.html { redirect_back(fallback_location: '') }
          format.json { render :show, status: :created, location: @clock_edit }
        else

          format.html { render :new }
          format.json { render json: @clock_edit.errors, status: :unprocessable_entity }
        end
      end
    end

    # PATCH/PUT /clock_edits/1
    # PATCH/PUT /clock_edits/1.json
    def update
      respond_to do |format|
        if @clock_edit.update(clock_edit_params)
          @clock_edit.clock_record.update_attributes(:record_type => params["timeclock_clock_edit"]["clock_record_record_type"], :timestamp => params["timeclock_clock_edit"]["clock_record_timestamp"] )
          format.html { redirect_back(fallback_location: '') }
          format.json { render :show, status: :ok, location: @clock_edit }
        else
          format.html { render :edit }
          format.json { render json: @clock_edit.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /clock_edits/1
    # DELETE /clock_edits/1.json
    def destroy
      @clock_edit.destroy
      respond_to do |format|
        format.html { redirect_to timeclock_clock_edits_url, notice: 'Clock edit was successfully destroyed.' }
        format.json { head :no_content }
      end
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_clock_edit
        @clock_edit = ClockEdit.find(params[:id])
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def clock_edit_params
        params.require(:timeclock_clock_edit).permit(:clock_record_id, :user_id, :ip_address, :reason_id, :deleted_at, :note, :clock_record_record_type)
      end
  end
end
