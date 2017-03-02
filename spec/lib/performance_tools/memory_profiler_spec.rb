require 'spec_helper'

describe PerformanceTools::MemoryProfiler do
  let(:console_buffer) { [] }
  let(:dummy_console) do
    obj = double('DummyConsole')
    allow(obj).to receive(:puts) do |msg|
      console_buffer << msg
    end
    obj
  end
  let(:memory_profiler_on) { true }

  before :all do
    # prime ObjectSpace
    described_class.start
  end

  before :each do
    allow(described_class).to receive(:console).and_return(dummy_console)
    allow(described_class).to receive(:memory_profiler_on?).and_return(memory_profiler_on)
  end

  describe '.track' do
    context 'when a hash has been instantiated' do
      let(:code_under_test) do
        ->() { hsh = { hello: 1234 } }
      end

      it 'report one hsh item' do
        res = described_class.track do
          code_under_test.()
        end
        expect(console_buffer[0].split("\n")).to include('| hash   |     1 |')
        expect(res).to eq( { hello: 1234 } )
      end

      context 'when memory profiling is off' do
        let(:memory_profiler_on) { false }

        it 'does not report' do
          res = described_class.track do
            code_under_test.()
          end
          expect(console_buffer).to be_empty
          expect(res).to eq( { hello: 1234 } )
        end
      end
    end
  end

  describe '.finish' do
    context 'when a hash has been instantiated' do
      let(:code_under_test) do
        ->() { hsh = {a: 1, b: 2} }
      end

      it 'reports one hsh item' do
        described_class.start
        code_under_test.()
        diff = described_class.finish
        expect(console_buffer[0].split("\n")).to include('| hash   |     1 |')
      end
    end

    context 'when one Object is instantiated' do
      let(:code_under_test) do
        ->() { Object.new }
      end

      it 'reports one Object item' do
        described_class.start
        code_under_test.()
        diff = described_class.finish
        expect(console_buffer[0].split("\n")).to include('| object |     1 |')
      end
    end
  end
end
