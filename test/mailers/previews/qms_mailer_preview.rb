# Preview all emails at http://localhost:3000/rails/mailers/qms_mailer
class QmsMailerPreview < ActionMailer::Preview

  def task_assignment_email
    QmsMailer.task_assignment_email Task.first
  end

  def task_completion_email
    QmsMailer.task_completion_email Task.first
  end

end
