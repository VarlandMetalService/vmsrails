class AddOvenSideToOptoLogs < ActiveRecord::Migration[5.1]
  def change
    change_table :opto_logs do |t|
      t.integer :oven, default: nil
      t.string :side, limit: 1, default: nil
    end
  end
end
