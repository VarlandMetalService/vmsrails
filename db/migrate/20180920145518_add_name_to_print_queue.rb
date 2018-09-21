class AddNameToPrintQueue < ActiveRecord::Migration[5.1]
  def change
    add_column :print_queues, :name, :string
    add_column :workstations, :ip_address, :string
  end
end
