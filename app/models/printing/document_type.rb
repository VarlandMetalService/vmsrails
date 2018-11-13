module Printing
  class DocumentType < ApplicationRecord
    self.table_name = "document_types"
    has_many :print_queue_rules
  end
end
