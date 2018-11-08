class RejectedPartsMailer < ApplicationMailer
  helper :application

  default from: 'varlandmetalservice@gmail.com',
            to: 'Richard Legacy <richard.legacy@varland.com>'
            # to: 'Richard Legacy <richard.legacy@varland.com>, 
            #      Joel Perrine <joel.perrine@varland.com>, 
            #      Mike Mitchell Jr <mick.mitchell.jr@varland.com>,
            #      Brian Mangold <brian.mangold@varland.com>,
            #      Greg Turner <greg.turner@varland.com>,
            #      Tony Fuson <tony.fuson@varland.com>,
            #      Gerald Cappelletti <gerald.cappelletti@varland.com>,
            #      Robert Beatty <robert.beatty@varland.com>,
            #      Ross Varland <ross.varland@varland.com>'
            
  def send_rejected_part(part, pdf_id)
    @pdf = Printing::PrintJob.find(pdf_id).file
    @part = part
    @filename = @pdf.instance_variable_get('@file').filename
    attachments.inline[@filename] = @pdf.read
    make_bootstrap_mail(subject: 'Rejected Part',
                         locals: { :part => @part, :pdf => @pdf })
  end
end