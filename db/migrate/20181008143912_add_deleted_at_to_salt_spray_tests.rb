class AddDeletedAtToSaltSprayTests < ActiveRecord::Migration[5.1]
  def change
    add_column :salt_spray_tests, :deleted_at, :time
  end
end
