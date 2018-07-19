class CommentsController < ApplicationController
    before_action :authenticate_user

    def create
        @comment = @commentable.comments.new comment_params
        if @comment.save
            flash[:success] = "Comment created."
            redirect_to shift_note_path(@commentable)
        else
            flash[:failure] = "Comment creation failed."
        end
    end

    def destroy
        @comment = @commentable.comments.find(params[:id])
        @comment.destroy
        respond_to do |format|
            format.html { redirect_to edit_shift_note_path(@commentable), notice: 'Comment was successfully destroyed.' }
            format.json { head :no_content }
        end
    end


        private

            def comment_params
                params.require(:comment).permit(:body, :attachment, :user_id)
            end


    end

