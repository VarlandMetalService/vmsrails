module Printing
  class PrintQueue < ApplicationRecord
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
      
    def self.lpr
      cmd = "lpr "
      cmd << self.printer << " "
      cmd << self.options
      return cmd
    end

  end
end