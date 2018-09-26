class AddWeightAndSupervisorToRejectedParts < ActiveRecord::Migration[5.1]
  def change
    add_column :qc_rejected_parts, :weight, :string
    add_column :qc_rejected_parts, :supervisor_id, :integer
  end
end
