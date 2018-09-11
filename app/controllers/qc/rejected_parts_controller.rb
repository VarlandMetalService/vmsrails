module Qc
  class RejectedPartsController < ApplicationController
    before_action :set_rejected_part, only: [:show, :edit, :update, :destroy, :create_pdf]

    def index
        @rejected_parts = RejectedPart.all
    end

    def show
    end

    def new
      @rejected_part = RejectedPart.new
    end

    def edit
    end

    def create
      @rejected_part = RejectedPart.new(rejected_part_params)
      respond_to do |format|
        if @rejected_part.save
          format.html { redirect_to qc_rejected_parts_path, notice: 'Rejected Part succesfully created.'}
          format.json { render :show, status: :created, location: @rejected_part }
        else
            format.html { render :new }
            format.json { render json: @rejected_part.errors, status: :unprocessable_entity}
        end
      end
    end

    def update
      respond_to do |format|
        if @rejected_part.update(rejected_part_params)
          format.html { redirect_to qc_rejected_parts_path, notice: 'Rejected Part succesfully updated.'}
          format.json { render :show, status: :ok, location: @rejected_part }
        else
            format.html { render :edit }
            format.json { render json: @rejected_part.errors, status: :unprocessable_entity}
        end
      end
    end

    def destroy
      @rejected_part.destroy
      respond_to do |format|
        format.html { redirect_to qc_rejected_parts_url, notice: 'Rejected Part successfully destroyed.' }
        format.json { head :no_content }
      end
    end

    def create_pdf
    end

    private

      def set_rejected_part
        @rejected_part=RejectedPart.find(params[:id])
      end

      def rejected_part_params
          params.require(:qc_rejected_part).permit(:so_num, :user_id, :date, :reject_tag_num, :from_tag, :defect, :loads_approved, :approved_by, :section2_comments, :load_nums, :barrel_nums, :tank_nums, :cause,    :s2box, :s3box)
      end

  end
end