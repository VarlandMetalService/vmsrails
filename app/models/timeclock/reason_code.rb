module Timeclock
  class Timeclock::ReasonCode < ApplicationRecord
    belongs_to :clock_edit, class_name: 'Timeclock::ClockEdit', optional: true
  end
end
