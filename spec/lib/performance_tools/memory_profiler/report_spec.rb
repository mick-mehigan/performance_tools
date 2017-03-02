require 'spec_helper'

describe PerformanceTools::MemoryProfiler::Report do
  let(:console_buffer) { [] }
  let(:dummy_console) do
    obj = double('DummyConsole')
    allow(obj).to receive(:puts) do |msg|
      console_buffer << msg
    end
    obj
  end
  let(:object_hash) { { T_ARRAY: 1, T_STRING: 2, T_CLASS: 3000 } }
  let(:object_count_hash) { PerformanceTools::MemoryProfiler::ObjectCountHash.new(object_hash) }

  describe '.output' do
    let(:expected) do
      [
        '+--------+-------+',
        '| Object | Count |',
        '+--------+-------+',
        '| array  |     1 |',
        '| string |     2 |',
        '| class  | 3,000 |',
        '+--------+-------+',
        '| Total  | 3,003 |',
        '+--------+-------+',
        ''
      ].join("\n")
    end

    it 'renders the output as expected' do
      described_class.output(dummy_console, object_count_hash)
      expect(console_buffer).to match_array(expected)
    end
  end
end
