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

    def send_note(note, group)
      @commentable = ShiftNote.find(note.id)
      recipient = nil
      @commentable.comments.each do |c|
        if c.attachment?
            @filename = c.attachment.instance_variable_get('@file').filename
            attachments.inline[@filename] = c.attachment.read
        end
      end
      case group
        when 'IT'
          recipient = 'Richard Legacy <richard.legacy@varland.com>'            #'IT <it@varland.com>'
        when 'Lab'
          recipient = 'Lab <lab@varland.com>'
        when 'Maintenance'
          recipient = 'Maintenance <maint@varland.com>'
        when 'QC'
          recipient = 'QC <qcshiftnotes@varland.com>'
        when 'Shipping'
          recipient = 'Shipping <shippingshiftnotes@varland.com>'
        else
          return
      end
      mail(subject: 'New Shift Note',
            to: recipient)
    end

    def send_daily_summary
      @note_array = ShiftNote.where(:created_at => Date.yesterday)
      @note_array.each do |n|
        n.comments.each do |c|
          if c.attachment?
              @filename = c.attachment.instance_variable_get('@file').filename
              attachments.inline[@filename] = c.attachment.read
          end
        end
      end
      mail(subject: 'Shift Note Summary!',
                    to: ["Richard Legacy <richard.legacy@varland.com>"])
    end
end
