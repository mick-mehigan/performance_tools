module PerformanceTools
  module ExceptionTrace
    class Report
      def self.output(console, results)
        results.each do |res|
          console.puts("[Exception] #{res.message} => #{res.count}")
        end
      end
    end
  end
end
