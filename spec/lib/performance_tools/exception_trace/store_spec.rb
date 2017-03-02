require 'spec_helper'

describe PerformanceTools::ExceptionTrace::Store do
  describe '#<<' do
    let(:exception) { 'Invalid characters' }

    it 'stores the exception' do
      subject << exception
      expect(subject.message_count).to eq 1
      expect(subject.map(&:message)).to match_array([exception])
    end
  end

  describe '#map' do
    let(:message) { 'Some message' }

    context 'when no messages are stored' do
      it { expect(subject.map(&:message)).to match_array([]) }
    end

    context 'when message is stored 3 times' do
      before { 3.times { subject << message } }

      it { expect(subject.map(&:count).inject(0, :+)).to eq 3 }
      it { expect(subject.map(&:message)).to match_array([message]) }
    end
  end

  describe '#message_count' do
    context 'when 3 different messages are registered multiple times' do
      let(:message_1) { 'Some message' }
      let(:message_2) { 'Some other message' }
      let(:message_3) { 'Yet another message' }

      before :each do
        2.times { subject << message_1 }
        3.times { subject << message_2 }
        5.times { subject << message_3 }
      end
      it { expect(subject.message_count).to eq 3 }
    end
  end

  describe '#total_count' do
    context 'when 3 different messages are registered multiple times' do
      let(:message_1) { 'Some message' }
      let(:message_2) { 'Some other message' }
      let(:message_3) { 'Yet another message' }

      before :each do
        2.times { subject << message_1 }
        3.times { subject << message_2 }
        5.times { subject << message_3 }
      end
      it { expect(subject.total_count).to eq 10 }
    end
  end
end
