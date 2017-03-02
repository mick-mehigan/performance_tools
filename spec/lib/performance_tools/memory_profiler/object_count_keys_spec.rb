require 'spec_helper'

describe PerformanceTools::MemoryProfiler::ObjectCountKeys do
  describe '.to_str' do
    [
      { key: 'T_STRING', expected: 'string' },
      { key: :T_ARRAY, expected: 'array' },
    ].each do |test_data|
      context "when key is '#{test_data[:key]}'" do
        let(:key) { test_data[:key] }
        let(:expected) { test_data[:expected] }

        it { expect(described_class.to_str(key)).to eq expected }
      end
    end
  end
end
