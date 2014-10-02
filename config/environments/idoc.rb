Inlook::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = true

  # Show full error reports and disable caching.
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false
  
  # Disable Rails's static asset server (Apache or nginx will already do this).
  # config.serve_static_assets = false

  # Compress JavaScripts and CSS.
  # config.assets.js_compressor = :uglifier

  # config.assets.comress = false

  # Do not fallback to assets pipeline if a precompiled asset is missed.
  # config.assets.compile = false
  # Generate digests for assets URLs.
  # config.assets.digest = true
  config.assets.debug = true

  # Specifies the header that your server uses for sending files.
  config.action_dispatch.x_sendfile_header = 'X-Accel-Redirect'
  
  # Set to :debug to see everything in the log.
  config.log_level = :info

  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = false

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

end
