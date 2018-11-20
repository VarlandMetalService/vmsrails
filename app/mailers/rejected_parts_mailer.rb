class RejectedPartsMailer < ApplicationMailer
  helper :application

  # CHANGE_THIS 
  default from: 'varlandmetalservice@gmail.com',
            to: 'Rejected Parts <rejectedparts@varland.com>'
            
  def send_rejected_part(part, pdf_id)
    @pdf = Printing::PrintJob.find(pdf_id).file
    @part = part
    @filename = @pdf.instance_variable_get('@file').filename
    attachments.inline[@filename] = @pdf.read
    make_bootstrap_mail(subject: 'Rejected Part',
                         locals: { :part => @part, :pdf => @pdf })
  end
end