namespace :shift_notes do
    desc 'send_shift_notes_summary'
    task send_shift_notes_summary: :environment do
        ShiftNotesMailer.send_daily_summary.deliver_now
end
  end