class MaterialsController < ApplicationController

  skip_before_action  :authenticate_user

  has_scope :sorted_by,
            only: :vat_history_notes,
            default: nil,
            allow_blank: true
  has_scope :with_search_term, only: :vat_history_notes
  has_scope :with_timestamp_gte, only: :vat_history_notes
  has_scope :with_timestamp_lte, only: :vat_history_notes
  has_scope :with_vat, only: :vat_history_notes
  has_scope :with_department, only: :vat_history_notes
  has_scope :with_user, only: :vat_history_notes
  
  def vat_history_notes
    @unpaged_vat_history_notes = apply_scopes(Materials::VatHistoryNote).includes(:vat, :user)
    @vat_history_notes = @unpaged_vat_history_notes.page(params[:page])
  end
end
