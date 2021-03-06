require_relative 'boot'

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "action_cable/engine"
# require "sprockets/railtie"
require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module TutorboxApi
  class Application < Rails::Application
    config.load_defaults 5.1
    config.i18n.default_locale = :'pt-BR'
    config.autoload_paths << Rails.root.join('lib')
    config.autoload_paths << Rails.root.join('app/graphql/mutations')
    Dir[File.join(Rails.root, 'app', 'exceptions', '*.rb')].each { |l| require l }
    Dir[File.join(Rails.root, 'lib', '*.rb')].each { |l| require l }
    config.api_only = true
  end
end
