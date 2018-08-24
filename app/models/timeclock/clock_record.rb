module Timeclock
  class Timeclock::ClockRecord < ApplicationRecord
    has_one :clock_edit, class_name: 'Timeclock::ClockEdit', required: false, dependent: :destroy
    belongs_to :user, class_name: 'User'
    accepts_nested_attributes_for :clock_edit
    # belongs_to :period, class_name: 'Timeclock::Period', optional: true
    self.table_name = "clock_records"

    # Options for select
    def self.options_for_record_type
      [['Start Work' , 'Start Work'],
       ['End Work'   ,   'End Work'],
       ['Start Break','Start Break'],
       ['End Break'  ,  'End Break'],
       ['Note'       ,       'Note']]
    end
  end
end
