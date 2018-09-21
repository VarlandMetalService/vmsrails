class ShiftNotesMailerPreview < ActionMailer::Preview
  def send_daily_summary
   ShiftNotesMailer.send_daily_summary
 end
  def send_comments
   ShiftNotesMailer.send_comments(User.first, ShiftNote.first)
 end
  def send_note
   ShiftNotesMailer.send_note(ShiftNote.first, 'IT')
 end
end