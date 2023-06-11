require_relative "boot"

require "rails"
%w(
  active_record/railtie
  active_storage/engine
  action_controller/railtie
  action_view/railtie
  active_job/railtie
  action_cable/engine
  action_text/engine
  action_mailer/railtie
  action_mailbox/engine
).each do |railtie|
  begin
    require railtie
  rescue LoadError
  end
end     

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module JawabAi
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    # Use sidekiq for active jobs
    config.active_job.queue_adapter = :sidekiq

    config.web_console.permissions = ENV.fetch('DOCKER_HOST') { '10.89.0.0/16' }

    config.generators do |g|
      g.helpers = false
      g.stylesheets = false
      g.assets = false
      g.javascripts = false
    end

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
  end
end
