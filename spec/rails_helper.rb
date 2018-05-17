
ENV['RAILS_ENV'] ||= 'test'
abort("The Rails environment is running in production mode!") if Rails.env.production?

require 'spec_helper'
require File.expand_path('../../config/environment', __FILE__)
require 'rspec/rails'

ActiveRecord::Migration.maintain_test_schema!

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end

RSpec.configure do |config|
  config.global_fixtures = :all
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
end
