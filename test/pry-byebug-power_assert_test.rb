require_relative 'test_helper'
require 'stringio'

class Pry::Byebug::PowerAssertTest < Test::Unit::TestCase
  class << self
    def startup
      Pry.config.color = false
      Pry.config.pager = false
      Pry.config.should_load_rc      = false
      Pry.config.should_load_local_rc= false
      Pry.config.should_load_plugins = false
      Pry.config.history.should_load = false
      Pry.config.history.should_save = false
      Pry.config.correct_indent      = false
      Pry.config.hooks               = Pry::Hooks.new
      Pry.config.collision_warning   = false
    end
  end

  def redirect_pry_io(new_in, new_out)
    old_in = Pry.input
    old_out = Pry.output
    Pry.input = new_in
    Pry.output = new_out
    begin
      yield
    ensure
      Pry.input = old_in
      Pry.output = old_out
    end
  end

  def test_automatic_inspection
    input = StringIO.new('next')
    output = StringIO.new
    redirect_pry_io(input, output) do
      binding.pry
      0.to_s
    end
    assert_include(output.string, <<END)
      0.to_s
        |
        "0"
END
  end
end
