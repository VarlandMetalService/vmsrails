class InlineAttachmentsController < ApplicationController
  before_action :set_inline_attachment, only: [:show, :edit, :update, :destroy]

  # GET /inline_attachments
  # GET /inline_attachments.json
  def index
    @inline_attachments = InlineAttachment.all
  end

  # GET /inline_attachments/1
  # GET /inline_attachments/1.json
  def show
  end

  # GET /inline_attachments/new
  def new
    @inline_attachment = InlineAttachment.new
  end

  # GET /inline_attachments/1/edit
  def edit
  end

  # POST /inline_attachments
  # POST /inline_attachments.json
  def create
    @inline_attachment = InlineAttachment.new(inline_attachment_params)

    respond_to do |format|
      if @inline_attachment.save
        format.html { redirect_to @inline_attachment, notice: 'Inline attachment was successfully created.' }
        format.json { render :show, status: :created, location: @inline_attachment }
      else
        format.html { render :new }
        format.json { render json: @inline_attachment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /inline_attachments/1
  # PATCH/PUT /inline_attachments/1.json
  def update
    respond_to do |format|
      if @inline_attachment.update(inline_attachment_params)
        format.html { redirect_to @inline_attachment, notice: 'Inline attachment was successfully updated.' }
        format.json { render :show, status: :ok, location: @inline_attachment }
      else
        format.html { render :edit }
        format.json { render json: @inline_attachment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /inline_attachments/1
  # DELETE /inline_attachments/1.json
  def destroy
    @inline_attachment.destroy
    respond_to do |format|
      format.html { redirect_to inline_attachments_url, notice: 'Inline attachment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_inline_attachment
      @inline_attachment = InlineAttachment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def inline_attachment_params
      params.require(:inline_attachment).permit(:file, :file_cache)
    end
end
