module Timeclock
  class Timeclock::ClockEdit < ApplicationRecord
    belongs_to :clock_record, class_name: 'Timeclock::ClockRecord',    optional: true
    belongs_to :reason_code, class_name: 'Timeclock::ReasonCode', required: false
    self.table_name = "clock_edits"

    delegate :record_type, :record_type=, :timestamp, :timestamp=, to: :clock_record, prefix: true

  end
end
