class AddCapabilityToClassifications < ActiveRecord::Migration[5.1]
  def change
    add_column :classifications, :not_capable, :boolean
  end
end
