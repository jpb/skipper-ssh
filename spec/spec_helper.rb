require 'vcr'
require 'simplecov'

SimpleCov.start

VCR.configure do |c|
  c.configure_rspec_metadata!
  c.hook_into                               :webmock
  c.allow_http_connections_when_no_cassette = false
  c.default_cassette_options                = { record: :once }
  c.cassette_library_dir                    = 'spec/support/vcr_cassettes'
end

RSpec.configure do |config|
  config.run_all_when_everything_filtered = true
  config.filter_run :focus
  config.order = 'random'

  config.mock_with :rspec do |c|
    c.syntax = [:should, :expect]
  end

  config.expect_with :rspec do |c|
    c.syntax = [:should, :expect]
  end
end
