module PerformanceTools
  module ExceptionTrace
    class Store
      include Enumerable

      def <<(message)
        if store[message].nil?
          store[message] = StoreItem.new(message)
        else
          store[message].increment
        end
      end

      def each(&block)
        store.values.each(&block)
      end

      def message_count
        store.count
      end

      def total_count
        self.inject(0) { |count, item| count += item.count }
      end

      private

      def store
        @store ||= {}
      end
    end
  end
end
