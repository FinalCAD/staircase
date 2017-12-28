require 'bundler/setup'

begin
  require 'pry'
rescue LoadError
end

require_relative '../lib/composer'

RSpec.configure do |c|
  c.run_all_when_everything_filtered = true
end
