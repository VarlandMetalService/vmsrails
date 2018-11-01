class ShiftNotesController < ApplicationController
  include ApplicationHelper
  before_action :set_shift_note, only: [:show, :edit, :update, :destroy]

  has_scope :with_search_term,   only: :index
  has_scope :with_timestamp,     only: :index
  has_scope :with_shift_type,    only: :index
  has_scope :with_shift_time,    only: :index
  has_scope :with_dept,          only: :index
  has_scope :with_user,          only: :index
  has_scope :sorted_by,          only: :index

  def index 
    check_permission('shift_notes')
    @shift_notes = apply_scopes(ShiftNote).includes(:comments, :user).all.page(params[:page])
    respond_to do |format|
      format.html
      format.json { render :json => @shift_notes }
    end
  end

  def show
    check_permission('shift_notes')
  end

  def new
    check_permission('shift_notes')
    @shift_note = ShiftNote.new(created_at: prod_date, shift_time: prod_shift)
  end

  def edit
    check_permission('shift_notes')
  end

  def create
    check_permission('shift_notes')
    @shift_note = ShiftNote.new(shift_note_params) 
    if @shift_note.save
      flash[:success] = "Shift note created."
      ShiftNotesMailer.send_note(@shift_note, @shift_note.shift_type).deliver_later
      respond_to do |format|
        format.html { redirect_to shift_note_path(@shift_note)}
        format.json { render :json => @shift_note }
      end
    else
      render :action => 'new'
      Rails.logger.info(@shift_note.errors.inspect)
    end 
  end

  def update
      if @shift_note.update(shift_note_params)
        flash[:success] = "Shift note updated."
        redirect_to shift_note_path(@shift_note)
      else
        render 'edit'
      end
  end

  def destroy
    @shift_note.destroy
    respond_to do |format|
      format.html { redirect_to shift_notes_url, notice: 'Shift note was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Select shift note by id.
    def set_shift_note
      @shift_note = ShiftNote.find(params[:id])
    end

    # Never trust parameters from the internet, only allow the white list.
    def shift_note_params
      params.require(:shift_note).permit(:id, :shift_time, :shift_type, :dept, 
                                         :user_id, :message, :created_at)
    end
end

