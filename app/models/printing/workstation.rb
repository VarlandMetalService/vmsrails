module Printing
  class Workstation < ApplicationRecord
    self.table_name = "workstations"
    has_many :print_queue_rules
    
  end
end
