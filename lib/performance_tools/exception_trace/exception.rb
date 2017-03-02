module PerformanceTools
  module ExceptionTrace
    class Exception
      def initialize(exception_klass, *args)
        @exception_klass = exception_klass
        @args = args
      end

      def message
        "#{@exception_klass.name} - #{@args.first&.to_str}"
        # if @args.first
        #   @args.first.to_str
        # else
        #   @exception_klass.name
        # end
      end
    end
  end
end
