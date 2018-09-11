module Timeclock
  class Timeclock::ClockPeriod < ApplicationRecord
    has_many :clock_records
    self.table_name = 'clock_periods'
  end
end