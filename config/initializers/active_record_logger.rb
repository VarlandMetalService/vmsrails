# Create logger that ignores messages containing “CACHE” and "base64"
class CacheFreeLogger < ::Logger
  def debug(message, *args, &block)
    if message.include? 'CACHE' 
    elsif message.include? 'PrintJobsController#create'
    else
      super
    end
  end
end

# Overwrite ActiveRecord’s logger
ActiveRecord::Base.logger = ActiveSupport::TaggedLogging.new(
  CacheFreeLogger.new(STDOUT)) unless Rails.env.test?