require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Futzal
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2
    I18n.enforce_available_locales = false
    I18n.config.available_locales = :ru
    config.i18n.default_locale = :ru
    config.assets.initialize_on_precompile = false
    
    
    
     config.action_mailer.perform_deliveries = true
  config.action_mailer.raise_delivery_errors = true
 
  
  config.action_mailer.delivery_method = :sendmail
  config.middleware.use Rack::MethodOverride

  config.middleware.use ActionDispatch::Session::CookieStore, {:key=>"_futzal_session", :cookie_only=>true}


   # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end
