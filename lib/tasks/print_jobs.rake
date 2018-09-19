namespace :print_jobs do
  desc "Delete print_jobs older than 14 days"
  task delete_old_print_jobs: :environment do
    Printing::PrintJob.where(['created_at < ?', 14.days.ago]).destroy_all
  end
end