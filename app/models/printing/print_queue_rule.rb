module Printing
  class PrintQueueRule < ApplicationRecord

    # Associations
    belongs_to :print_queue, optional: true
    belongs_to :user, optional: true
    belongs_to :workstation_group, optional: true
    has_many   :workstations, through: :workstation_group
    belongs_to :document_type, optional: true

    # Validations.
    validates_presence_of :print_queue_id

    # Scopes
    scope :with_user, ->(user) { where("user_id = ?", user) unless user.nil? }
    scope :with_doc_type, ->(doc_type) { where("document_type_id = ?", doc_type) unless doc_type.nil? }
    scope :with_workstation, ->(workstation) { where("workstation_group_id = ?", workstation) unless workstation.nil? }
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

        def weight
            temp = 0.00
            if !self.workstation_group_id.blank?
                temp += 5
                temp -= 0.001*self.workstation_group.workstations.size
            end
            if !self.user_id.blank?
                temp += 7
            end
            if !self.document_type_id.blank?
                temp += 3
            end
            return temp
        end
  end
end