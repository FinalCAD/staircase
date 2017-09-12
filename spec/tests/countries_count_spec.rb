require 'spec_helper'

describe CountriesCount do
  let(:matrix) do
    [
      [5,4,4],
      [4,3,4],
      [3,2,4],
      [2,2,2],
      [3,3,4],
      [1,4,4],
      [4,1,1]
    ]
  end
  it do
    expect(subject.solution(matrix)).to eql(11  )
  end
end
