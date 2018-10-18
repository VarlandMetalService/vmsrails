class SaltSprayTestMailer < ApplicationMailer
  helper :application
  add_template_helper(SaltSprayTestsHelper)

  default from: 'varlandmetalservice@gmail.com',
            to: 'Shift Notes Recipients <dailyshiftnotes@varland.com>'

  def send_test(s, recipient)
    @salt_spray_test = s
    s.comments.each do |c|
      if c.attachment?
        c.attachment.each do |f|
          @filename = f.instance_variable_get('@file').filename
          attachments.inline[@filename] = f.read
        end
      end
    end
    make_bootstrap_mail(subject: 'Salt Spray Test', to: recipient, locals: { :s => s })
  end
end
