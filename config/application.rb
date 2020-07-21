require_relative 'boot'

require 'rails/all'

require "graphql/client/railtie"
require "graphql/client/http"


# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module MyAppRails
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
  end
end

module GitHub
  class Application < Rails::Application
  end

  HTTPAdapter = GraphQL::Client::HTTP.new("https://api.github.com/graphql") do
    def headers(context)
      {
          "Authorization" => "Bearer GitHubTokenAccess"
      }
    end
  end

  Client = GraphQL::Client.new(
      schema: Application.root.join("db/schema.json").to_s,
      execute: HTTPAdapter
  )
  Application.config.graphql.client = Client
end
