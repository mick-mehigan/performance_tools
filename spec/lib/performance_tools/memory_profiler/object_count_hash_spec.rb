require 'spec_helper'

describe PerformanceTools::MemoryProfiler::ObjectCountHash do
  describe '#-' do
    let(:rhs) do
      PerformanceTools::MemoryProfiler::ObjectCountKeys::KEYS.inject({}) do |hsh, key|
        hsh[key] = 1
        hsh
      end
        
    end
    let(:lhs) do
      obj = rhs.dup
      obj[:T_STRING] += 1
      obj[:T_ARRAY] += 2
      obj
    end

    subject { described_class.new(lhs) }

    it 'returns the difference' do
      diff = subject - described_class.new(rhs)
      expect(diff.object_count_hash).to eq({ T_STRING: 1, T_ARRAY: 2 })
    end
  end
end
