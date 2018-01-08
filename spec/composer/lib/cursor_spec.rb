require 'spec_helper'

describe Composer::Lib::Cursor do
  describe '#move' do

    subject { described_class.new(columns: 3, rows: 2) }

    it do
      {
        1 => { column: 0, row: 0 },
        2 => { column: 1, row: 0 },
        3 => { column: 2, row: 0 },
        4 => { column: 0, row: 1 },
        5 => { column: 1, row: 1 },
        6 => { column: 2, row: 1 },
        7 => { column: 0, row: 0 },
        8 => { column: 1, row: 0 },
        9 => { column: 2, row: 0 }
      }.each do |iteration, coordinate|
        position = subject.move

        expect(position.column.to_i).to eql(coordinate[:column])
        expect(position.row.to_i).to    eql(coordinate[:row])
      end
    end
  end
end
