class CommentsController < ApplicationController
    before_action :authenticate_user
    skip_before_action :verify_authenticity_token

    def create
        @comment = @commentable.comments.new comment_params
        if @comment.save
            if @commentable.class == ShiftNote
                # send_emails(@commentable)
            else
            end
            flash[:success] = "Comment created."
            redirect_back(fallback_location: root_path)
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
                params.require(:comment).permit(:body, :user_id, { attachment:[]} )
            end

            def send_emails(commentable)
                @commentable = commentable
                @user = @commentable.user
                recipient_array = Array.new
                recipient_array << @user

                ShiftNotesMailer.send_comments(@user, @commentable).deliver_now

                @commentable.comments.each do |c|
                    @user = c.user
                    if recipient_array.include?(@user)
                    else
                        ShiftNotesMailer.send_comments(@user, @commentable).deliver_now
                        recipient_array << @user
                    end
                end 
            end
end

