class CreateClockPeriodTable < ActiveRecord::Migration[5.1]
  def change
    create_table :clock_periods do |t|
      t.datetime :start_date
      t.datetime :end_date
      t.boolean :finalized
    end
  end
end
