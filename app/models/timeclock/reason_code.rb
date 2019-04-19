module Timeclock
  class Timeclock::ReasonCode < ApplicationRecord
    has_many :clock_edits, class_name: 'Timeclock::ClockEdit'
  end
end
