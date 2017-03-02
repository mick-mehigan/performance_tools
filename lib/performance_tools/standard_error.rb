class StandardError
  def initialize(*args)
    PerformanceTools::ExceptionTrace::Counter.instance.add_exception(self.class, args.first)
    super
  end
end
