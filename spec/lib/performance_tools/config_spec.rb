require 'spec_helper'

describe PerformanceTools::Config do
  describe '#console' do
    it { expect(subject.console).to eq $stdout }
  end

  describe '#exception_trace_on' do
    it { expect(subject.exception_trace_on).to eq false }
  end

  describe '#memory_profiler_on' do
    it { expect(subject.memory_profiler_on).to eq true }
  end
end
