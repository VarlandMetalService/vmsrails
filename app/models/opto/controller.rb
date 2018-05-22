class Opto::Controller < ApplicationRecord

  # Associations.
  has_many :logs, dependent: :destroy

end
