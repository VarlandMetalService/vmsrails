module Timeclock
  class Timeclock::ClockRecord < ApplicationRecord
    has_one :clock_edit, class_name: 'Timeclock::ClockEdit', required: false, dependent: :destroy
    belongs_to :clock_period, class_name: 'Timeclock::ClockPeriod', required: false
    belongs_to :user, class_name: 'User'
    accepts_nested_attributes_for :clock_edit
    self.table_name = "clock_records"

    # Validations.
    validates_presence_of :user_id, :record_type, :timestamp

    # Options for select
    def self.options_for_record_type
      [['Start Work' , 'Start Work'],
       ['End Work'   ,   'End Work'],
       ['Start Break','Start Break'],
       ['End Break'  ,  'End Break'],
       ['Note'       ,       'Note'],
       ['Holiday'    ,    'Holiday']]
    end
  end
end