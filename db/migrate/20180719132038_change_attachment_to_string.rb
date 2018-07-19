class ChangeAttachmentToString < ActiveRecord::Migration[5.1]
  def change
    change_column :comments, :attachments, :string
    rename_column :comments, :attachments, :attachment
  end
end
