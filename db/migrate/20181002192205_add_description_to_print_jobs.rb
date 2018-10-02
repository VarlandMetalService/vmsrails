class AddDescriptionToPrintJobs < ActiveRecord::Migration[5.1]
  def change
    add_column :print_jobs, :description, :string
  end
end
