module PerformanceTools
  module MemoryProfiler
    def self.start
      if memory_profiler_on?
        GC.disable
        @benchmark = count_objects
      end
    end

    def self.finish
      if memory_profiler_on? && @benchmark
        res = adjust(count_objects) - @benchmark
        @benchmark = nil
        GC.enable
        Report.output(console, res)
        res
      end
    end

    def self.track(&block)
      start
      res = yield if block_given?
      finish

      res
    end

    private

    def self.console
      PerformanceTools.config.console
    end

    def self.memory_profiler_on?
      PerformanceTools.config.memory_profiler_on
    end

    def self.adjust(count_hash)
      count_hash.object_count_hash[:T_HASH] -= 1
      count_hash.object_count_hash[:T_OBJECT] -= 1
      count_hash
    end

    def self.count_objects
      MemoryProfiler::ObjectCountHash.new(ObjectSpace.count_objects)
    end
  end
end
