class DeptInfo::Folder < ApplicationRecord

  acts_as_nested_set

  # Scoping.
  default_scope { order(:parent_id, :name) }

  # Associations.
  has_many :documents, dependent: :destroy

  # Validation.
  validates :name,
            presence: { message: 'You must enter a folder name' },
            uniqueness: { scope: :parent_id,
                          message: 'Folder names must be unique within a parent folder' }

end
