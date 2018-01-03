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
  INTERNAL_LIB_DIRS[Pry::Byebug::PowerAssert] = __dir__
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
            sep = Pry::Helpers::Text.green('-' * (Pry::Terminal.width! - 1))
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
