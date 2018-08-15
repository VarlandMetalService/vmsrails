module Thickness
  class Thickness::Check < ActiveRecord::Base
    belongs_to :block, class_name: 'Thickness::Block',foreign_key: "block_id", optional: true, touch: true
    self.table_name = "thickness_checks"

  end
end