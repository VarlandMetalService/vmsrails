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
            flash[:danger] = "Comment deleted."
            format.html { redirect_back(fallback_location: root_path) }
            format.json { head :no_content }
        end
    end

        private
        def comment_params
            params.require(:comment).permit(:body, :user_id, :comments_count, { attachment:[]} )
        end
end

