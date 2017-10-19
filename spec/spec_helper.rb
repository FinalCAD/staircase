require 'bundler/setup'

begin
  require 'pry'
rescue LoadError
end

# require_relative 'support/adapters/active_record'
require_relative '../lib/change_locale'
# require_relative '../lib/tests/elevator_stops'
# require_relative '../lib/tests/countries_count'

# Dir['../../lib/tests/*.rb'].each { |f| require f }
# Dir[File.expand_path('../lib/tests/*.rb', __FILE__)].each { |f| require f }

RSpec.configure do |c|
  c.run_all_when_everything_filtered = true
end
