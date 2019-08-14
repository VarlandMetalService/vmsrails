module Opto

  TOBY = "toby.varland@varland.com"
  TOBY_CELL = "8594964920@vtext.com"

  def self.table_name_prefix
    'opto_'
  end

  def self.options_for(field)
    case field 
    when "sort"
      [['Newest'           , 'newest'             ],
       ['Oldest'           , 'oldest'             ],
       ['Controller'       , 'controller'         ],
       ['Type'             , 'type'               ],
       ['Controller & Type', 'controller_and_type']].sort
    when "controller"
      Opto::Controller.pluck(:name, :id).uniq.sort
    when "type"
      Opto::Log.pluck(:type).uniq.map { |t| [t.demodulize.titleize, t]}.sort
    end
  end
end
