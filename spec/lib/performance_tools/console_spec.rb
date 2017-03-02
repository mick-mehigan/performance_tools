require 'spec_helper'

describe PerformanceTools::Config do
  describe '#console' do
    it { expect(subject.console).to eq $stdout }
  end
end
