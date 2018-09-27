module Printing
  class PrintQueue < ApplicationRecord
    # Validations.
    validates_presence_of :printer, :name
    scope :with_search_term, ->(term){
      unless term.blank?
      search = ApplicationController.helpers.split_search_terms(term)
      conditions = []
      parameters = {}
      term_index = 1

      search[:include].each do |t|
          key = "search#{term_index}"
          conditions << "printer LIKE :#{key}"
          parameters[key] = "%#{t}%"
          term_index += 1
      end
      search[:exclude].each do |t|
          key = "search#{term_index}"
          conditions << "printer NOT LIKE :#{key}"
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

    def self.printer_options
      [['Lexmark-T644', '-P Lexmark-T644'],
       ['MP-C3004ex'  , '-P MP-C3004ex'  ]]
    end

    def self.option_flags
      [['Copies: (number)'   , '-# '],
       ['Landscape: (blank)', '-o RIOrientOvr=Landscape']]
    end

  end
end