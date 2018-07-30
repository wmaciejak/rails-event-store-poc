require_relative 'boot'

require 'rails/all'
require 'aggregate_root'

Bundler.require(*Rails.groups)

module RorRes
  class Application < Rails::Application
    config.enable_dependency_loading = true
    config.autoload_paths << Rails.root.join('lib')
    config.autoload_paths << Rails.root.join('concepts','lib')
    config.load_defaults 5.2
    config.api_only = true
    config.to_prepare do
      Rails.configuration.event_store = RailsEventStore::Client.new(
        dispatcher: ::SidekiqAsyncDispatcher.new
      )

      AggregateRoot.configure do |config|
        config.default_event_store = Rails.configuration.event_store
      end
    end
  end
end
