namespace :dept_info do
  desc "Update all Google documents from Google Drive"
  task update_google_documents: :environment do
    loader = DeptInfo::Loader.new
    loader.load
  end
end