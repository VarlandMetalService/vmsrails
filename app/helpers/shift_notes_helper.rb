module ShiftNotesHelper
    def preview_or_default_image(c)
        case c.attachment.file.extension
        when 'pdf'
          'pdf.png'
        else
            c.attachment_url(:thumb)
        end
      end
end
