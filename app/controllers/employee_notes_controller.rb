class EmployeeNotesController < ApplicationController

  before_action :set_note, only: [:edit, :update, :destroy]
  before_action :require_user_permission

  has_scope :sorted_by,
            only: :index,
            default: nil,
            allow_blank: true
  has_scope :with_search_term, only: :index
  has_scope :with_employee, only: :index
  has_scope :with_entered_by, only: :index
  has_scope :with_note_type, only: :index
  has_scope :with_date_gte, only: :index
  has_scope :with_date_lte, only: :index

  def index
    # CHANGE THIS w/ PLUCK
    if @access_level >= 3
      @employee_notes = apply_scopes(EmployeeNote).page(params[:page])
      @unpaged_employee_notes = apply_scopes(EmployeeNote)
    else
      @employee_notes = apply_scopes(EmployeeNote.with_entered_by(@current_user.id)).page(params[:page])
      @unpaged_employee_notes = apply_scopes(EmployeeNote.with_entered_by(@current_user.id))
    end
  end

  def new
    @employee_note = EmployeeNote.new
  end

  def create
    @employee_note = EmployeeNote.new(employee_note_params)
    @employee_note.author = @current_user
    @employee_note.ip_address = request.remote_ip
    if @employee_note.save
      redirect_to employee_notes_url
    else
      render :action => 'new'
    end
  end

  def edit
  end

  def destroy
    @employee_note.destroy
    redirect_back(fallback_location: employee_notes_url)
  end

  def update
    if @employee_note.update_attributes(employee_note_params)
      redirect_to employee_notes_url
      return
    else
      render :action => 'edit'
    end 
  end

private

  def require_user_permission
    require_permission 'employee_notes', 2
  end

  def set_note
    @employee_note = EmployeeNote.find params[:id]
  end

  def employee_note_params
    params.require(:employee_note).permit(:employee,
                                          :note_on,
                                          :note_type,
                                          :notes,
                                          :follow_up,
                                          :follow_up_on)
  end

end