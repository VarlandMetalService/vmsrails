module Opto

  BRIAN_CELL = "5133820273@vtext.com"
  BRIAN_EMAIL = "brian.mangold@varland.com"
  CLIFF_CELL = "5134700754@messaging.sprintpcs.com"
  FOREMAN_EMAIL = "vmsforemen@gmail.com"
  GREG_CELL = "5133820271@vtext.com"
  GREG_EMAIL = "greg.turner@varland.com"
  IT_EMAIL = "it@varland.com"
  JOEL_CELL = "5132849588@vtext.com"
  JOEL_EMAIL = "joel.perrine@varland.com"
  LAB_EMAIL = "varlandlab@gmail.com"
  RICH_CELL = "5138140536@vtext.com"
  RICH_EMAIL = "rich.branson@varland.com"
  ROSS_CELL = "5133820277@vtext.com"
  ROSS_EMAIL = "ross.varland@varland.com"
  TED_CELL = "5134768439@vtext.com"
  TOBY_CELL = "8594964920@vtext.com"
  TOBY_EMAIL = "toby.varland@varland.com"
  
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
