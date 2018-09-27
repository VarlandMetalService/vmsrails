module Printing
  class PrintQueueRule < ApplicationRecord
    # Validations.
    validates_presence_of :print_queue_id

    scope :with_user, ->(user) { where("user_id = ?", user) unless user.nil? }
    scope :with_doc_type, ->(doc_type) { where("document_type_id = ?", doc_type) unless doc_type.nil? }
    scope :with_workstation, ->(workstation) { where("workstation_id = ?", workstation) unless workstation.nil? }
    scope :with_search_term, ->(term){
        unless term.blank?
        search = ApplicationController.helpers.split_search_terms(term)
        conditions = []
        parameters = {}
        term_index = 1
        search[:include].each do |t|
            key = "search#{term_index}"
            conditions << "message LIKE :#{key}"
            parameters[key] = "%#{t}%"
            term_index += 1
        end
        search[:exclude].each do |t|
            key = "search#{term_index}"
            conditions << "message NOT LIKE :#{key}"
            parameters[key] = "%#{t}%"
            term_index += 1
        end
        where(conditions.join(' AND '), parameters.symbolize_keys)
        end}
  end
end