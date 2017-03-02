require 'spec_helper'

describe PerformanceTools::ExceptionTrace::StoreItem do
  let(:message) { 'Hello, World!' }
  subject { described_class.new(message) }

  describe '#message' do
    it { expect(subject.message).to eq message }
    it { expect(subject.count).to eq 1 }
  end

  describe '#increment' do
    it 'increments the count' do
      expect(subject.count).to eq 1
      subject.increment
      expect(subject.count).to eq 2
    end
  end
end
