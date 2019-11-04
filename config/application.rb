require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module GsLicManagerDEV
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
    ActionMailer::Base.smtp_settings = {
        :address => 'smtp.gs-software.pl',
        :domain => 'mail.gs-software.pl',
        :port => 465,
        :user_name => ENV['MAIL_LOGIN'],
        :password => ENV['MAIL_PASSWORD'],
        :enable_starttls_auto => true,
        :ssl => true,
        :openssl_verify_mode  => 'none'
    }
  end
end
