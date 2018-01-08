require 'spec_helper'

describe Composer::Lib::Grid do
  {
    1 => { columns: 1, rows: 1 },
    2 => { columns: 2, rows: 1 },
    3 => { columns: 2, rows: 2 },
    4 => { columns: 2, rows: 2 },
    5 => { columns: 3, rows: 2 }
  }.each do |number_of_images, grid|
    it do
      g = described_class.new(number_of_images)
      expect(g.columns).to eql(grid[:columns])
      expect(g.rows).to eql(grid[:rows])
    end
  end

  describe '#move' do

    subject { described_class.new(6) }

    it do
      expect(subject.columns).to eql(3)
      expect(subject.rows).to eql(2)
    end

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
