class ShiftNotesMailer < ApplicationMailer
    helper  :application

    default from: 'varlandmetalservice@gmail.com',
            to: ['Shift Notes Recipients <dailyshiftnotes@varland.com>']

    def send_comments(user, commentable)
        @user = user
        @commentable = commentable

        @commentable.comments.each do |c|
            if c.attachment?
                @filename = c.attachment.instance_variable_get('@file').filename
                attachments.inline[@filename] = c.attachment.read
            end
        end

        mail(subject: 'New shift note comment!',
                       to: ["#{@user.full_name} <#{@user.email}>"])   
    end
end
