# Create logger that ignores messages containing “CACHE”
class CacheFreeLogger < ::Logger
  def debug(message, *args, &block)
    if message.include? 'CACHE' 
    elsif message.include? 'base64'
    else
      super
    end
  end
end

# Overwrite ActiveRecord’s logger
ActiveRecord::Base.logger = ActiveSupport::TaggedLogging.new(
  CacheFreeLogger.new(STDOUT)) unless Rails.env.test?