require 'spec_helper'

describe PerformanceTools::ExceptionTrace::Report do
  let(:console_buffer) { [] }
  let(:dummy_console) do
    obj = double('DummyConsole')
    allow(obj).to receive(:puts) do |msg|
      console_buffer << msg
    end
    obj
  end

  context 'when results are empty' do
    let(:results) { [] }

    it 'does not output any results' do
      described_class.output(dummy_console, results)
      expect(console_buffer).to eq []
    end
  end

  context 'when one result is registered' do
    let(:store_item) { instance_double(PerformanceTools::ExceptionTrace::StoreItem, message: 'do not do that', count: 1) }
    let(:results) { [store_item] }
    let(:expected) do
      [
        '[Exception] do not do that => 1'
      ]
    end

    it 'outputs the result' do
      described_class.output(dummy_console, results)
      expect(console_buffer).to eq expected
    end   
  end

  context 'when multiple results are registered' do
    let(:messages) { ['do not do that', 'missing argument', 'invalid character'] }
    let(:results) do
      messages.map { |msg| instance_double(PerformanceTools::ExceptionTrace::StoreItem, message: msg, count: 1) }
    end
    let(:expected) do
      [
        '[Exception] do not do that => 1',
        '[Exception] missing argument => 1',
        '[Exception] invalid character => 1'
      ]
    end

    it 'outputs the result' do
      described_class.output(dummy_console, results)
      expect(console_buffer).to eq expected
    end   
  end
end
