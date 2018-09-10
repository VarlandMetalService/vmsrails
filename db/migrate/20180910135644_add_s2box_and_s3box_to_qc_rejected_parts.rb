class AddS2boxAndS3boxToQcRejectedParts < ActiveRecord::Migration[5.1]
  def change
    add_column :qc_rejected_parts, :s2box, :boolean
    add_column :qc_rejected_parts, :s3box, :boolean
  end
end
