module Printing
  class Workstation < ApplicationRecord
    self.table_name = "workstations"
    has_and_belongs_to_many :workstation_groups
    
  end
end
