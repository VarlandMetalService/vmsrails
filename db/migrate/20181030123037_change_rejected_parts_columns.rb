class ChangeRejectedPartsColumns < ActiveRecord::Migration[5.1]
  def change
    rename_column :qc_rejected_parts, :section2_comments, :cause_category
    change_column :qc_rejected_parts, :cause_category, :string
  end
end
