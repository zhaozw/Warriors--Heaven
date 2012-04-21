# Be sure to restart your server when you modify this file

# Specifies gem version of Rails to use when vendor/rails is not present
RAILS_GEM_VERSION = '2.3.5' unless defined? RAILS_GEM_VERSION

# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|
  # Settings in config/environments/* take precedence over those specified here.
  # Application configuration should go into files in config/initializers
  # -- all .rb files in that directory are automatically loaded.

  # Add additional load paths for your own custom dirs
  # config.load_paths += %W( #{RAILS_ROOT}/extras )

  # Specify gems that this application depends on and have them installed with rake gems:install
  # config.gem "bj"
  # config.gem "hpricot", :version => '0.6', :source => "http://code.whytheluckystiff.net"
  # config.gem "sqlite3-ruby", :lib => "sqlite3"
  # config.gem "aws-s3", :lib => "aws/s3"

  # Only load the plugins named here, in the order given (default is alphabetical).
  # :all can be used as a placeholder for all plugins not explicitly named
  # config.plugins = [ :exception_notification, :ssl_requirement, :all ]

  # Skip frameworks you're not going to use. To use Rails without a database,
  # you must remove the Active Record framework.
  # config.frameworks -= [ :active_record, :active_resource, :action_mailer ]

  # Activate observers that should always be running
  # config.active_record.observers = :cacher, :garbage_collector, :forum_observer

  # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
  # Run "rake -D time" for a list of tasks for finding time zone names.
  config.time_zone = 'UTC'


  # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
  # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}')]
  # config.i18n.default_locale = :de
  config.action_controller.session_store = :active_record_store
  #config.action_controller.session_store = :mem_cache_store
  config.action_controller.session = {
    :key => '_wh_session',
    :secret=>'4a9e7a59871177d8cfc7798c2ffb24c6a9f1a066ebd8fcc6a96e7827b3f36fcdf17907512e52b8259ae36af2f89cbf858b48421a33842b6f686ccb80e816412f',
  #  :expire_after => 86400*30*100
  :expire_after => 0
    }

=begin
require 'memcache'
require 'memcache_util'
#require 'cgi/session.rb'
require 'action_controller/session/mem_cache_store.rb'
require 'active_support/cache/mem_cache_store.rb'
require 'memcache'
    # memcache defaults, environments may override these settings
    unless defined? MEMCACHE_OPTIONS then
        MEMCACHE_OPTIONS = {
            :debug => false,
            :namespace => 'my_memcache',
            :readonly => false
        }
    end
    # memcache configuration
    unless defined? MEMCACHE_CONFIG then
    File.open "#{RAILS_ROOT}/config/memcache.yml" do |memcache|
    MEMCACHE_CONFIG = YAML::load memcache
    end
    end
    # Connect to memcache
    unless defined? CACHE then
    CACHE = MemCache.new MEMCACHE_OPTIONS
    CACHE.servers = MEMCACHE_CONFIG[RAILS_ENV]
    end
    # Configure the session manager to use memcache data store
    ActionController::CgiRequest::DEFAULT_SESSION_OPTIONS.update(
    :database_manager => CGI::Session::MemCacheStore,
    :cache => CACHE, :expires => 3600 * 12)
=end
=begin 
require 'memcache' 
memcache_options = { 
   :compression => true, 
   :debug => true, 
   :namespace => "_wh_session", 
   :readonly => false, 
   :urlencode => true 
} 

memcache_servers = ['localhost:11211'] 
cache_params = *([memcache_servers, memcache_options].flatten) 
# 
SESSION_CACHE = MemCache.new *cache_params 
=end
=begin
config.session_store = { 
  :key         => '_wh_session', 
  :secret     =>'4a9e7a59871177d8cfc7798c2ffb24c6a9f1a066ebd8fcc6a96e7827b3f36fcdf17907512e52b8259ae36af2f89cbf858b48421a33842b6f686ccb80e816412f', 
  :cache       => SESSION_CACHE, 
  :expires     => 3600*24*7 
} 
=end
   end
