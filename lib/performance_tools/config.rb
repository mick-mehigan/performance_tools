module PerformanceTools
  class Config
    attr_accessor :console, :exception_trace_on, :memory_profiler_on

    def initialize
      self.console = $stdout
      self.exception_trace_on = false
      self.memory_profiler_on = true
    end
  end
end
