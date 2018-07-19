class ShiftNotes::CommentsController < CommentsController
    before_action :set_commentable

        private

        def set_commentable
            @commentable = ShiftNote.find(params[:shift_note_id])
        end
end
