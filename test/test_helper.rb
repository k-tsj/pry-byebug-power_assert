$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

begin
  require 'bundler'
  Bundler.require
rescue LoadError
end

require 'test/unit'
require 'pry/byebug/power_assert'
