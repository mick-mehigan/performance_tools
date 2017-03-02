module PerformanceTools
  module ExceptionTrace
    class StoreItem
      attr_reader :message, :count

      def initialize(message)
        @message = message
        @count = 1
      end

      def increment
        @count += 1
      end
    end
  end
end
