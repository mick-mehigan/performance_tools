require 'spec_helper'

describe StandardError do
  let(:counter) { PerformanceTools::ExceptionTrace::Counter.instance }

  before { allow(PerformanceTools.config).to receive(:exception_trace_on).and_return(true) }

  describe 'initialize' do
    let(:exception_klass) { NoMethodError }
    let(:exception_message) { 'no method error' }

    it 'records the error in the counter' do
      expect(counter.count).to eq 0
      expect(counter.type_count).to eq 0

      exception = exception_klass.new(exception_message)

      expect(counter.count).to eq 1
      expect(counter.results.map(&:message)).to match_array(["#{exception_klass.name} - #{exception_message}"])
      expect(counter.count).to eq 1
      expect(counter.type_count).to eq 1
    end
  end
end
