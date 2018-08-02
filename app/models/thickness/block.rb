module Thickness
  class Thickness::Block < ActiveRecord::Base
    has_many :checks, class_name: 'Thickness::Check', dependent: :destroy
    accepts_nested_attributes_for :checks
    self.table_name = "thickness_blocks"
    default_scope { order(updated_at: :desc) }

    paginates_per 30

  end
end