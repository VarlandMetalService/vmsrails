require 'rails_helper'
RSpec.describe ShiftNotesController, type: :controller do
  include SessionsHelper

  fixtures :users

  before(:each) do
    log_in(users(:one))
  end

  describe "GET index" do
    it "assigns @shift_notes" do
      shift_note = ShiftNote.create
      get :index
      expect(assigns(:shift_notes)).to eq([shift_note])
    end
  end
end