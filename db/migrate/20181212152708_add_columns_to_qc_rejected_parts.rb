class AddColumnsToQcRejectedParts < ActiveRecord::Migration[5.1]
  def change
    add_column :qc_rejected_parts, :sec1_loads, :string
    add_column :qc_rejected_parts, :defect_description, :text
  end
end
