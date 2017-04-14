require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Oauth
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    config.to_prepare do
      Doorkeeper::ApplicationsController.layout "application"
      Doorkeeper::AuthorizedApplicationsController.layout "application"
    end
    config.action_view.field_error_proc = Proc.new { |html_tag, instance| 
      html_tag
    }
    config.action_view.embed_authenticity_token_in_remote_forms = true
  end
end
