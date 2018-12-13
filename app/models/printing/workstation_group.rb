module Printing
  class WorkstationGroup < ApplicationRecord
    self.table_name = "workstation_groups"

    has_and_belongs_to_many :workstations
    
  end
end
