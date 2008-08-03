RAILS_GEM_VERSION = '2.1.0' unless defined? RAILS_GEM_VERSION

require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|
  config.gem "vpim"
  config.gem "simple-rss"
  config.gem "methodphitamine"

  config.action_controller.session = {
    :session_key => '_rubybrigade_session',
    :secret      => 'c459720a5c2784dc24acf43707c082a4'
  }
end