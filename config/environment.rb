# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

Time::DATE_FORMATS[:custom_datetime] = "%d %B %Y %H:%M:%S"
require 'carrierwave/orm/activerecord'
