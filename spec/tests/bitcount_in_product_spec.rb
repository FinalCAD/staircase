require 'spec_helper'

describe BitcountInProduct do
  it { expect(subject.solution(variable_a: 3, variable_b: 7)).to eql(3) }
end
