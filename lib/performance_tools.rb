require 'performance_tools/config'

module PerformanceTools

  def self.configure
    yield(config)
  end

  private

  def self.config
    @config ||= Config.new
  end
end

require 'performance_tools/exception_trace'
require 'performance_tools/exception_trace/counter'
require 'performance_tools/exception_trace/report'
require 'performance_tools/exception_trace/store'
require 'performance_tools/exception_trace/store_item'
require 'performance_tools/exception_trace/exception'
require 'performance_tools/memory_profiler'
require 'performance_tools/memory_profiler/object_count_hash'
require 'performance_tools/memory_profiler/object_count_keys'
require 'performance_tools/memory_profiler/report'
require 'performance_tools/standard_error'
require 'performance_tools/tabularise/table'
