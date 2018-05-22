class Opto::Log < ApplicationRecord

  # Associations.
  belongs_to :controller

  # Instance methods.

  def parse_controller_timestamp(raw)
    raw_timestamp = ::DateTime.strptime(raw, "%m/%d/%Y %H:%M:%S")
    self.controller_timestamp = ::ActiveSupport::TimeZone['Eastern Time (US & Canada)'].parse(raw_timestamp.strftime('%Y-%m-%m %H:%M:%S'))
  end

end
