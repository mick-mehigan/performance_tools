module PerformanceTools
  module ExceptionTrace
    def self.track(&block)
      start
      res = yield if block_given?
      finish

      res
    end

    def self.start
      Counter.instance.clear
    end

    def self.finish
      Report.output(PerformanceTools.config.console, Counter.instance.results)
    end
  end
end
