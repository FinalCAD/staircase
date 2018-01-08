require 'pry'

source_path = 'spec/fixtures/archive/input'
instance = Composer::Import::Dir.new(source_path)
instancier = Composer::Import::Instancier.new

loop do
  break unless (model = instance.next)
  next if model.skip?
  instancier.call(model)
end

registry = Composer::Stores::Registry.instance
registry.staircases

Staircases\<Staircase Name>\Sectors\<Sector Name>.json
Staircases\<Staircase Name>\Sectors\<Sector Name>.pdf
Staircases\<Staircase Name>\Zones\<Sector Name>.json
Staircases\<Staircase Name>\Zones\<Sector Name>.pdf

Sectors\<Staircase Name>.png
Sectors\<Staircase Name>.json
Zones\<Staircase Name>\<Sector Name> <Zone name>.png
Zones\<Staircase Name>\<Sector Name> <Zone name>.json
