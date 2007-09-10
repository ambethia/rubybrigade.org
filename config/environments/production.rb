# Settings specified here will take precedence over those in config/environment.rb

# The production environment is meant for finished, "live" apps.
# Code is not reloaded between requests
config.cache_classes = true

# Use a different logger for distributed setups
# config.logger = SyslogLogger.new

# Full error reports are disabled and caching is turned on
config.action_controller.consider_all_requests_local = false
config.action_controller.perform_caching             = true

# Enable serving of images, stylesheets, and javascripts from an asset server
# config.action_controller.asset_host                  = "http://assets.example.com"

# Disable delivery errors, bad email addresses will be ignored
# config.action_mailer.raise_delivery_errors = false

# require authentication for exception_logger
config.after_initialize do
  require 'application' unless Object.const_defined?(:ApplicationController)
  LoggedExceptionsController.class_eval do
    requires_authentication :using => Proc.new{ |username, password| password == 'bluefish' },
                            :realm => 'RubyBrigade!!!!'
  end
end

ENV["RECAPTCHA_PUBLIC_KEY"]  = "6LfrXQAAAAAAADTzQtdY-4Z5UJn7bBbjtf35k5Qj"
ENV["RECAPTCHA_PRIVATE_KEY"] = "6LfrXQAAAAAAAFClQSFjsY0EHDiqkQTK6f8iYex2"

ROOT_URL = "http://rubybrigade.org"