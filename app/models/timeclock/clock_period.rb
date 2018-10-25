module Timeclock
  class Timeclock::ClockPeriod < ApplicationRecord
    has_many :clock_records
    has_many :users,        through: :clock_records
    has_many :clock_edits,  through: :clock_records
    self.table_name = 'clock_periods'
  end
end