namespace :delete do
  desc 'Delete successfull print jobs older than 3 days'
  task :old_records => :environment do
    Model.where('is_complete = /', true).where('created_at < ?', 3.days.ago).each do |model|
      model.destroy
    end

    # or Model.delete_all('created_at < ?', 60.days.ago) if you don't need callbacks
  end
end