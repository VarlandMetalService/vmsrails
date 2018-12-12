module Printing
  class PrintQueueRule < ApplicationRecord

    belongs_to :print_queue, optional: true
    belongs_to :user, class_name: 'User', optional: true
    belongs_to :workstation, optional: true
    belongs_to :document_type, optional: true
    # Validations.
    validates_presence_of :print_queue_id

    scope :with_user, ->(user) { where("user_id = ?", user) unless user.nil? }
    scope :with_doc_type, ->(doc_type) { where("document_type_id = ?", doc_type) unless doc_type.nil? }
    scope :with_workstation, ->(workstation) { where("workstation_id = ?", workstation) unless workstation.nil? }
    scope :with_weight, -> (weight) { where('weight = ?', weight) unless weight.nil? }
    scope :with_print_queue, -> (print_queue) { where('print_queue_id = ?', print_queue) unless print_queue.nil? }
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