class CommentsController < ApplicationController
    before_action :authenticate_user
    skip_before_action :verify_authenticity_token

    def create
        @comment = @commentable.comments.new comment_params
        if @comment.save
            if @comment.commentable_type == 'ShiftNote'
                ShiftNotesMailer.send_note(@commentable, @commentable.shift_type).deliver_later
            end
            flash[:success] = "Comment created."
            redirect_back(fallback_location: root_path)
        else
            flash[:failure] = "Comment creation failed."
        end
    end

    def destroy
        @comment = Comment.find(params[:id])
        @comment.destroy
        respond_to do |format|
            format.html { redirect_to edit_shift_note_path(@commentable), notice: 'Comment was successfully destroyed.' }
            format.json { head :no_content }
        end
    end

        private
        def comment_params
            params.require(:comment).permit(:body, :user_id, { attachment:[]} )
        end
end

