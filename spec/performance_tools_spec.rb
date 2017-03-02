require 'spec_helper'

describe PerformanceTools do
  describe 'VERSION' do
    it 'has a version number' do
      expect(PerformanceTools::VERSION).not_to be nil
    end
  end

  describe '.configure' do
    let(:dummy_config) { PerformanceTools::Config.new }
    before { allow(described_class).to receive(:config).and_return(dummy_config) }

    context 'when exception trace mode' do
      before :each do
        described_class.configure do |config|
          config.exception_trace_on = true
          config.memory_profiler_on = false
        end
      end

      it { expect(dummy_config.exception_trace_on).to eq true }
      it { expect(dummy_config.memory_profiler_on).to eq false }
    end

    context 'when exception trace mode' do
      before :each do
        described_class.configure do |config|
          config.exception_trace_on = false
          config.memory_profiler_on = true
        end
      end

      it { expect(dummy_config.exception_trace_on).to eq false }
      it { expect(dummy_config.memory_profiler_on).to eq true }
    end
  end
end
