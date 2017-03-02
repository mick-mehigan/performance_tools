require 'spec_helper'

describe PerformanceTools::ExceptionTrace do
  let(:console_buffer) { [] }
  let(:dummy_console) do
    obj = double('DummyConsole')
    allow(obj).to receive(:puts) do |msg|
      console_buffer << msg
    end
    obj
  end

  let(:expected_exception) { '[Exception] NoMethodError - undefined method `do_something_interesting\' for nil:NilClass => 1' }
  let(:raise_and_catch_exception) do
    ->() do
      begin
        nil.do_something_interesting
      rescue => e
        'Exception Raised'
      end
    end
  end
  let(:raise_no_method_error) do
    ->(argument) do
      begin
        raise NoMethodError, argument
      rescue => e
        nil
      end
    end
  end

  before :each do
    allow(PerformanceTools.config).to receive(:console).and_return(dummy_console)
    allow(PerformanceTools.config).to receive(:exception_trace_on).and_return(true)
  end

  describe '.track' do
    it 'tracks the error' do
      expect(console_buffer).to match_array([])
      res = described_class.track do
        raise_and_catch_exception.()
      end
      expect(console_buffer).to match_array([expected_exception])
      expect(res).to eq 'Exception Raised'
    end

    context 'when NoMethodError is raised without arguments' do
      let(:expected_exception) { '[Exception] NoMethodError -  => 1' }

      it 'dumps the NoMethodError message' do
        described_class.track do
          raise_no_method_error.(nil)
        end
        expect(console_buffer).to match_array([expected_exception])
      end
    end
  end

  describe '.finish' do
    it 'dumps results since Counter was started' do
      expect(console_buffer).to match_array([])
      described_class.start
      raise_and_catch_exception.()
      described_class.finish
      expect(console_buffer).to match_array([expected_exception])
    end
  end
end
