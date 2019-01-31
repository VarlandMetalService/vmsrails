module Qc
  class RejectedPartsController < ApplicationController
    before_action :set_rejected_part, only: [:show, :edit, :update, :destroy, :create_pdf, :recreate_pdf]
    def index
        @rejected_parts = RejectedPart.all
    end

    def show
    end

    def new
      session[:temp] = helpers.get_from_tags
      @rejected_part = RejectedPart.new 
    end

    def edit
    end

    def create
      @rejected_part = RejectedPart.new(rejected_part_params)
      
      @rejected_part.load_nums = RejectedPart.process_array(params[:qc_rejected_part][:load_nums]) unless params[:qc_rejected_part][:load_nums].blank?
      @rejected_part.tank_nums = RejectedPart.process_array(params[:qc_rejected_part][:tank_nums]) unless params[:qc_rejected_part][:tank_nums].blank?
      @rejected_part.barrel_nums = RejectedPart.process_array(params[:qc_rejected_part][:barrel_nums]) unless params[:qc_rejected_part][:barrel_nums].blank?
      respond_to do |format|
        if @rejected_part.save
          if @rejected_part.increment_reject_tag_count
            flash[:success] = "Successfully updated AS/400 S.O."
          else
            flash[:danger] = "Failed to update AS/400, S.O. # may not exist."
          end
          url = "http://remoteapi.varland.com:8882/v1/so?shop_order=#{@rejected_part.so_num}"
            uri = URI(url)
            response = Net::HTTP.get(uri)
            @part_info = JSON.parse(response, { symbolize_names: true }).first
            if @part_info.blank?
              @part_info = { shopOrder: "", customer: "", processCode: "", partID: "", subID: "" }
            end
          
          file = helpers.gen_pdf(@rejected_part, @part_info)
          RejectedPartsMailer.send_rejected_part(@rejected_part, @part_info).deliver_later
          format.html { redirect_to root_path }
          format.json { redirect_back(fallback_location: root_url) }
        else
            format.html { render :new }
            format.json { render json: @rejected_part.errors, status: :unprocessable_entity }
        end
      end
    end

    def update
      @rejected_part.load_nums = RejectedPart.process_array(params[:qc_rejected_part][:load_nums]) unless params[:qc_rejected_part][:load_nums].blank?
      @rejected_part.tank_nums = RejectedPart.process_array(params[:qc_rejected_part][:tank_nums]) unless params[:qc_rejected_part][:tank_nums].blank?
      @rejected_part.barrel_nums = RejectedPart.process_array(params[:qc_rejected_part][:barrel_nums]) unless params[:qc_rejected_part][:barrel_nums].blank?
      respond_to do |format|
        if @rejected_part.update(rejected_part_params)
          format.html { redirect_to qc_rejected_parts_path, notice: 'Rejected Part succesfully updated.'}
          format.json { render :show, status: :ok, location: @rejected_part }
        else
            format.html { render :new }
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

    def recreate_pdf
      file = helpers.gen_pdf(RejectedPart.find(params[:id]))
      respond_to do |format|
        format.html { redirect_to qc_rejected_parts_path }
        format.json { head :no_content }
      end
    end

    private

      def set_rejected_part
        @rejected_part=RejectedPart.find(params[:id])
      end

      def rejected_part_params
          params.require(:qc_rejected_part).permit(:so_num, :user_id, :date, :reject_tag_num, :from_tag, :defect, :loads_approved, :approved_by, :cause_category, :load_nums, :barrel_nums, :tank_nums, :cause,    :s2box, :s3box, :weight, :sec1_loads, :defect_description)
      end
  end
end