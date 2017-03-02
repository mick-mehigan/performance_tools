require 'spec_helper'

describe PerformanceTools::Tabularise::Table do
  let(:footer) { false }

  describe '#dump' do
    subject { described_class.new(footer: footer) }

    context 'without footer' do
      let(:footer) { false }
      let(:expected) do
        [
          '+--------+-----------+',
          '| Object | Count     |',
          '+--------+-----------+',
          '| String |       101 |',
          '| Array  |        99 |',
          '| Hash   |     2,022 |',
          '| Memo   | 2,053,373 |',
          '+--------+-----------+',
          ''
        ].join("\n")
      end

      it 'renders a table' do
        subject.add_line('Object', 'Count')
        subject.add_line('String', 101)
        subject.add_line('Array', 99)
        subject.add_line('Hash', 2_022)
        subject.add_line('Memo', 2_053_373)

        expect(subject.dump).to eq expected
      end
    end

    context 'with footer' do
      let(:footer) { true }
      let(:expected) do
        [
          '+--------+-------+',
          '| Object | Count |',
          '+--------+-------+',
          '| String |   101 |',
          '| Array  |    99 |',
          '| Hash   | 2,022 |',
          '+--------+-------+',
          '| Total  | 2,222 |',
          '+--------+-------+',
          ''
        ].join("\n")
      end

      it 'renders a table' do
        subject.add_line('Object', 'Count')
        subject.add_line('String', 101)
        subject.add_line('Array', 99)
        subject.add_line('Hash', 2022)
        subject.add_line('Total', 2222)

        expect(subject.dump).to eq expected
      end
    end
  end
end
