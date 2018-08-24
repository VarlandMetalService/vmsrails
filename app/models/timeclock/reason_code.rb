module Timeclock
  class Timeclock::ReasonCode < ApplicationRecord
    belongs_to :clock_edit, class_name: 'Timeclock::ClockEdit', required: true
  end
end
