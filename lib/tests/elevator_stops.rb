# Time 1:28:34

# def solution(a, b, m, x, y)
#   ElevatorStops.new.solution(person_weights: a, person_floors: b, top_floor: m, lift_capacity: x, lift_max_weight: y)
# end

class ElevatorStops
  def solution(person_weights:, person_floors:, top_floor:, lift_capacity:, lift_max_weight:)
    raise StandardError.new("Inconsistency Data") if person_weights.size != person_floors.size
    raise StandardError.new("Inconsistency Data") if person_floors.max > top_floor
    raise StandardError.new("Inconsistency Data") if lift_capacity < 1
    raise StandardError.new("Inconsistency Data") if lift_max_weight < 1

    sequencer = Sequencer.new
    trip      = Trip.new(weight_max: lift_max_weight, capacity: lift_capacity)

    person_weights.size.times.each do |index|
      person = Person.new(weight: person_weights[index], floor: person_floors[index])

      if LiftPolicy.new(trip).authorized?(person_weight: person.weight)
        sequencer.update(trip.floors)
        trip.reset
      end

      trip.add_person(person: person)
    end

    sequencer.update(trip.floors)
    sequencer.sequences
  end
end

class LiftPolicy
  def initialize(lisft_trip)
    @lisft_trip = lisft_trip
  end

  def authorized?(person_weight:)
    !(weight + person_weight <= weight_max && number_of_people < capacity)
  rescue
    false
  end

  def method_missing(method, *args)
    if lisft_trip.respond_to?(method)
      lisft_trip.send(method, *args)
    else
      super
    end
  end

  private
  attr_reader :lisft_trip
end

class Sequencer
  def initialize
    @sequences = []
  end

  def update(count)
    @sequences << count
  end

  def sequences
    @sequences.reduce(:+)
  end
end

class Trip
  attr_reader :capacity, :weight_max

  def initialize(weight_max:, capacity:)
    @weight_max = weight_max
    @capacity   = capacity
    @people     = []
  end

  def weight
    @people.map(&:weight).reduce(:+)
  end

  def floors
    (@people.map(&:floor).uniq.count + 1)
  end

  def number_of_people
    @people.size
  end

  def add_person(person:)
    @people << person
  end

  def reset
    @people = []
  end
end

class Person
  attr_reader :weight, :floor

  def initialize(weight:, floor:)
    @weight = weight
    @floor  = floor
  end
end


# Example test:    ([60, 80, 40], [2, 3, 5], 5, 2, 200)
# Output (stderr):
# exec.rb:37:in `authorized?': undefined method `+' for nil:NilClass (NoMethodError)
# 	from exec.rb:18:in `block in solution'
# 	from exec.rb:15:in `times'
# 	from exec.rb:15:in `each'
# 	from exec.rb:15:in `solution'
# 	from exec.rb:2:in `solution'
# 	from exec.rb:228:in `<main>'
# RUNTIME ERROR  (tested program terminated unexpectedly)
#
# Example test:    ([40, 40, 100, 80, 20], [3, 3, 2, 2, 3], 3, 5, 200)
# Output (stderr):
# exec.rb:37:in `authorized?': undefined method `+' for nil:NilClass (NoMethodError)
# 	from exec.rb:18:in `block in solution'
# 	from exec.rb:15:in `times'
# 	from exec.rb:15:in `each'
# 	from exec.rb:15:in `solution'
# 	from exec.rb:2:in `solution'
# 	from exec.rb:228:in `<main>'
# RUNTIME ERROR  (tested program terminated unexpectedly)
#
# Detected some errors.
