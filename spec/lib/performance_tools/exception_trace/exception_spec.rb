require 'spec_helper'

describe PerformanceTools::ExceptionTrace::Exception do
  describe '#message' do
    subject { described_class.new(exception_klass, exception_argument).message }

    context 'when exception is string' do
      let(:exception_klass) { StandardError }
      let(:exception_argument) { 'Some error' }
      let(:expected) { "#{exception_klass.name} - #{exception_argument}" }

      it { is_expected.to eq expected }
    end

    context 'when it is an instance of an Exception class' do
      let(:exception_klass) { NoMethodError }
      let(:exception_argument) { nil }
      let(:expected) { "#{exception_klass.name} - " }

      it { is_expected.to eq expected }
    end

    context 'when exception arguments has NameError::message' do
      let(:exception_klass) { StandardError }
      let(:exception_message) { 'do not be doing that' }
      let(:exception_argument) { double('NameError::message', to_str: exception_message) }
      let(:expected) { "#{exception_klass.name} - #{exception_message}" }

      it { is_expected.to eq expected }
    end
  end
end
