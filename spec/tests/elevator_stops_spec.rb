require 'spec_helper'

describe ElevatorStops do
  it do
    expect(ElevatorStops.new.solution(person_weights: [60,80,40], person_floors: [2,3,5], top_floor: 5, lift_capacity: 2, lift_max_weight: 200)).to eql(5)
    expect(ElevatorStops.new.solution(person_weights: [40,40,100,80,20], person_floors: [3,3,2,2,3], top_floor: 3, lift_capacity: 5, lift_max_weight: 200)).to eql(6)
  end
end
