require 'spec_helper'

describe PerformanceTools::ExceptionTrace::Counter do
  subject { described_class.instance }

  let(:exception_trace_on) { true }

  before { allow(PerformanceTools.config).to receive(:exception_trace_on).and_return(exception_trace_on) }
  after { subject.clear }

  describe '#add_exception' do
    let(:exception_message) { 'something has gone awry' }
    let(:exception_klass) { StandardError }
    let(:expected) { "#{exception_klass.name} - #{exception_message}" }

    it 'adds the exception to the store' do
      expect(subject.count).to eq 0
      subject.add_exception(exception_klass, exception_message)
      expect(subject.count).to eq 1
      expect(subject.results.map(&:message)).to match_array([expected])
    end

    context 'when config.exception_trace is off' do
      let(:exception_trace_on) { false }

      it 'does not add an exception to the store' do
        expect(subject.count).to eq 0
        subject.add_exception(exception_klass, exception_message)
        expect(subject.count).to eq 0
        expect(subject.results.map(&:message)).to match_array([])
      end
    end
  end

  describe '#count' do
    let(:exception_klass) { StandardError }
    let(:something_went_wrong) { 'something went wrong' }
    let(:that_is_not_good) { 'that is not good' }

    context 'when exception has been added multiple times' do
      before :each do
        subject.add_exception(exception_klass, something_went_wrong)
        subject.add_exception(exception_klass, that_is_not_good)
        subject.add_exception(exception_klass, something_went_wrong)
      end

      it { expect(subject.count).to eq 3 }
    end
  end

  describe '#type_count' do
    let(:exception_klass) { StandardError }
    let(:something_went_wrong) { 'something went wrong' }
    let(:that_is_not_good) { 'that is not good' }

    context 'when exception has been added multiple times' do
      before :each do
        subject.add_exception(exception_klass, something_went_wrong)
        subject.add_exception(exception_klass, that_is_not_good)
        subject.add_exception(exception_klass, something_went_wrong)
      end

      it { expect(subject.type_count).to eq 2 }
    end
  end

  describe '#results' do
   context 'when multple exceptions have been registered' do
     let(:exception_messages) { ['this is not a joke', 'how dare you', 'that was dumb'] }
     before :each do
       exception_messages.each { |msg| subject.add_exception(NoMethodError, msg) }
     end
     let(:expected) { exception_messages.map { |msg| "#{NoMethodError} - #{msg}" } }

     it 'returns the results of all exceptions raised' do
       results = subject.results
       expect(results.map(&:message)).to match_array(expected)
       expect(results.map(&:count)).to match_array([1, 1, 1])
     end
   end
  end

  describe '#clear' do
    context 'when an exception has been registered' do
      let(:exception_klass) { StandardError }
      let(:exception_message) { 'do not do that again' }

      it 'clears the store' do
        subject.add_exception(exception_klass, exception_message)
        expect(subject.count).to eq 1
        subject.clear
        expect(subject.count).to eq 0
      end
    end
  end
end
