module PerformanceTools
  module MemoryProfiler
    class Report
      def self.output(console, results)
        table = Tabularise::Table.new(footer: true)
        table.add_line('Object', 'Count')
        results.object_count_hash.each do |key, value|
          table.add_line(ObjectCountKeys.to_str(key), value)
        end
        table.add_line('Total', results.count)
        console.puts table.dump
      end

      def self.delimited(num)
        num.to_s.reverse.gsub(/...(?=.)/,'\&,').reverse
      end
    end
  end
end
