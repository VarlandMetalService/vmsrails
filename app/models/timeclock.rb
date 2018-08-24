module Timeclock
  def self.table_name_prefix
    'timeclock_'
  end

  def self.color_options
    {'Start Work' => 'bg-success', 
     'End Work' => 'bg-danger', 
     'Start Break' => 'bg-primary', 
     'End Break' => 'bg-info', 
     'Note' => 'text-dark'}
  end

end
