class ShiftNoteController
require 'rails_helper'
RSpec.describe ShiftNotesController, type: :controller do
  include SessionsHelper
  include ApplicationHelper

  fixtures :users

  before(:each) do
    log_in(users(:one))
  end

  describe "GET #index" do
    fixtures :shift_notes
    it "assigns @shift_notes" do
      get :index

      expect(
        assigns(:shift_notes)
        ).to eq([shift_notes(:one), shift_notes(:two), shift_notes(:invalid)])
    end
    it "render the :index view" do
      get :index 

      expect(
        response
        ).to render_template :index
    end
  end

  describe "GET #show" do
    fixtures :shift_notes
    it "assigns requested note to @shift_note" do
      get :show, params: { id: shift_notes(:one).id }

      expect(
        assigns(:shift_note)
        ).to eq(shift_notes(:one))
    end
    it "renders the :show template" do
      get :show, params: { id: 1 }

      expect(
        response
        ).to render_template :show
    end
  end

  describe "GET #new" do
    it "assigns a new note to @shift_note" do
      get :new

      expect(
        assigns(:shift_note)
        ).to be_a_new(ShiftNote)
    end
    it "renders the :new template" do
      get :new

      expect(
        response
        ).to render_template :new
    end
  end

  describe "GET #edit" do
    fixtures :shift_notes
    it "assigns requested note to @shift_note" do
      get :edit, params: { id: shift_notes(:one).id }

      expect(
        assigns(:shift_note)
        ).to eq(shift_notes(:one))
    end
    it "renders the :edit template" do
      get :edit, params: { id: shift_notes(:one).id }

      expect(
        response
        ).to render_template :edit
    end
  end

  describe "POST #create" do
    fixtures :shift_notes
    context "with valid attributes" do
      it "saves the new note to the db" do
        post_params = { shift_note: { shift_time: '1', user_id: '1', dept: '1', shift_type: 'IT', message: 'woopah' } }

        expect{
          post :create, :params => post_params 
          }.to change(ShiftNote, :count).by(1)
      end
      it "redirects to the :show template" do
        get :create, params: { shift_note: { shift_time: '1', user_id: '1', dept: '1', shift_type: 'IT', message: 'woopah' } }

        expect(
          response
          ).to redirect_to shift_note_path(assigns(:shift_note))
      end
    end

    context "with invalid attributes" do
      it "doesn't save new note to the db" do
        post_params = { shift_note: { shift_time: nil, user_id: nil } }

        expect{ 
          post :create, :params => post_params 
          }.to change(ShiftNote, :count).by(0)
      end
      it "re-renders the :new template" do
        get :create, params: { shift_note: { shift_time: nil, user_id: nil, dept: nil, shift_type: 'IT', message: 'woopah' } }

        expect(
          response
          ).to render_template :new 
      end
    end
  end
end
end