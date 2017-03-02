require 'singleton'

module PerformanceTools
  module ExceptionTrace
    class Counter
      include Singleton

      def add_exception(exception_klass, *exception_args)
        if exception_trace_on?
          msg = Exception.new(exception_klass, exception_args.first).message
          store << msg
        end
      end

      def results
        store
      end

      def count
        store.total_count
      end

      def type_count
        store.message_count
      end

      def clear
        @store = nil
      end

      private

      def store
        @store ||= Store.new
      end

      def exception_trace_on?
        PerformanceTools.config.exception_trace_on
      end
    end
  end
end
