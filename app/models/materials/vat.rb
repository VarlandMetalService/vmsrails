class Materials::Vat < ApplicationRecord

  # Associations.
  has_many :vat_history_notes, dependent: :destroy

end
