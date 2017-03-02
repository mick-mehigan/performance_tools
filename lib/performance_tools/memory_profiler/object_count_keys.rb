module PerformanceTools
  module MemoryProfiler
    class ObjectCountKeys
      KEYS = [
#        :TOTAL,
#        :FREE,
        :T_OBJECT,
        :T_CLASS,
        :T_MODULE,
        :T_FLOAT,
        :T_STRING,
        :T_REGEXP,
        :T_ARRAY,
        :T_HASH,
        :T_STRUCT,
        :T_BIGNUM,
        :T_FILE,
        :T_DATA,
        :T_MATCH,
        :T_COMPLEX,
        :T_RATIONAL,
        :T_SYMBOL,
        :T_IMEMO,
        :T_NODE,
        :T_ICLASS
      ]

      def self.to_str(key)
        key.to_s.split('_')[1].downcase
      end
    end
  end
end
