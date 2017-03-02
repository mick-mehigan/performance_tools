module PerformanceTools
  module MemoryProfiler
    class ObjectCountHash
      attr_reader :object_count_hash

      def initialize(object_count_hash)
        @object_count_hash = object_count_hash
      end

      def [](key)
        object_count_hash[key]
      end

      def count
        object_count_hash.values.inject(0, &:+)
      end

      def -(rhs)
        obj = ObjectCountKeys::KEYS.inject({}) do |hsh, key|
          res = (object_count_hash[key] || 0) - (rhs[key] || 0)
          if 0 != res
            hsh[key] = res
          end
          hsh
        end
        self.class.new(obj)
      end
    end
  end
end
