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
end
