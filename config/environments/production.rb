config.cache_classes = true
config.action_controller.consider_all_requests_local = false
config.action_controller.perform_caching             = true
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