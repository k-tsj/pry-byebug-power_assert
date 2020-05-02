require 'pry/byebug/power_assert/version'
require 'pry-byebug'
require 'power_assert'

begin
  verbose, $VERBOSE = $VERBOSE, nil
  require 'power_assert/colorize'
ensure
  $VERBOSE = verbose
end

module PowerAssert
  INTERNAL_LIB_DIRS[Pry::Byebug::PowerAssert] = File.dirname(caller_locations(1, 1).first.path)
end

module Byebug
  class PryProcessor
    prepend Module.new {
      def initialize(*)
        super
        @prev_power_assert_context = nil
      end

      def perform_next(*)
        @prev_power_assert_context = PowerAssert.trace(frame)
        super
      end

      def resume_pry
        if @prev_power_assert_context
          begin
            w = (defined?(Pry::Terminal) ? Pry::Terminal.width! : Pry.new(output: StringIO.new).output.width) - 1
            sep = Pry::Helpers::Text.green('-' * w)
            output.puts sep
            output.puts @prev_power_assert_context.message
            output.puts sep
          ensure
            @prev_power_assert_context.disable
            @prev_power_assert_context = nil
          end
        end
        super
      end
    }
  end
end
