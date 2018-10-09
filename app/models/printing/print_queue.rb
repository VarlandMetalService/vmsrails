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
      [['Office Ricoh'    , '-P Office_Ricoh'],
       ["Sales' Lexmark"  , '-P Sales_Lexmark_T644'],
       ["Gail's Lexmark"  , '-P Gail_Lexmark_T630'],
       ["Production Dell" , '-P Production_Dell_C3760dn'],
       ["Shipping Lexmark", '-P Shipping_Lexmark_T630'],
       ["Shipping Ricoh"  , '-P Shipping_Ricoh']]
    end

    def self.option_flags
      [['Copies: (number)'   , '-# '],
       ['Landscape: (blank)', '-o RIOrientOvr=Landscape']]
    end

  end
end