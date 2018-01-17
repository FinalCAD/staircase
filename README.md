# Staircase

Service to create Staircase

[![Maintainability](https://api.codeclimate.com/v1/badges/b555e20a16d6c8776959/maintainability)](https://codeclimate.com/github/FinalCAD/staircase/maintainability)

[![Dependency Status](https://gemnasium.com/FinalCAD/staircase.svg)](https://gemnasium.com/FinalCAD/staircase)

[![Build Status](https://travis-ci.org/FinalCAD/staircase.svg?branch=master)](https://travis-ci.org/FinalCAD/staircase) (Travis CI)

[![Coverage Status](https://coveralls.io/repos/FinalCAD/staircase/badge.svg?branch=master&service=github)](https://coveralls.io/github/FinalCAD/staircase?branch=master)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'staircase'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install staircase

## What's the purpose of this service

For some internal purpose, we need to perform some manipulations on generated archive of blueprints from plugin like AutoCAD Plugin or Revit Plugin

Basically, those plugins know how produced Sectors and Zones, but for some specific projects we need another type of blueprints composed of several Sectors into one, here a Staircase

Input files look like that :

```
Staircases\<Staircase Name>\Sectors\<Sector Name>.json
Staircases\<Staircase Name>\Sectors\<Sector Name>.pdf
Staircases\<Staircase Name>\Zones\<Sector Name>.json
Staircases\<Staircase Name>\Zones\<Sector Name>.pdf
```

We need to manipulate those files to obtain those ones :

```
Sectors\<Staircase Name>.png
Sectors\<Staircase Name>.json
Zones\<Staircase Name>\<Sector Name> <Zone name>.png
Zones\<Staircase Name>\<Sector Name> <Zone name>.json
```

### What's a Staircase?

A Staircase can be seen as a matrix; this matrix is the composition of sectors, it can have a variable number of columns and rows

### Models architecture

To simplify the manipulation of those different files, the library load in memory those files as model

```
-- Staircase
  |-- < Staircase Name >
    |-- Sectors
      |-- < Sector Name >.extension
    |-- Zones
      |-- < Sector Name >
        |-- < Zone Name >.extension
```

Like that we have all we need to be gathered in one Staircase model.

### Load model in memory

To load the models, we need to give an input directory where the original files can be found

`Composer::Import::Dir` browse a directory and for every file instance a model.

The instantiated model is quite basic, it safe to override it. Basically, it contains the path of the file and on `skip?` method.

You can override this way to ignore all path that doesn't contain the keyword `Staircases` for instance.

```
class MyModel < Composer::Model
  def skip?
    !source_path.match(/^Staircases/)
  end
end
```
We have a couple of models to represent the directory structure :

* Staircase
* Sector
* Zone

Once you have a BasicModel instance, you can give it to the `Instantiate` to let it instantiate the right model and put our instance in the right place.

`Composer::Import::Instantiate` is responsible for instantiating the appropriate model, a `Staircase`, `Sector` or `Zone` and put it where is belong.

```
source_path = 'spec/fixtures/archive/input'
instance    = Composer::Import::Dir.new(source_path, model=MyModel, context={})
instantiate = Composer::Import::Instantiate.new

loop do
  break unless (model = instance.next)
  next if model.skip?
  instantiate.call(model)
end
```
or

```
source_path = 'spec/fixtures/archive/input'
directory   = Composer::Import::Dir.new(source_path, model=MyModel, context={})

directory.each do |model|
  instantiate.call(model)
end
```

A shortcut to load models in memory

```
importer = Composer::Importer.new(source_path: 'spec/fixtures/archive/input')
importer.load
```

### Playing with Models

Once the model is loaded, you can access it in memory

```
registry = Composer::Stores::Registry.instance
registry.models
```

You can play easily with every file concerning a Staircase through their names

```
registry.models['Staircase Name 1'].sectors['R+1'].zones['Logement 12-11-=-Architecte'].path(:pdf).to_s
=> "spec/fixtures/archive/input/Staircases/Staircase Name 1/Zones/R+1/Logement 12-11-=-Architecte.pdf"
```

## Exporting

Basically, the export is a suite of processes, like imagemagick manipulations, decypher, conversion, executed by a series of components.

Those components can be chained.

You can invoke the exportation like :

```
Composer::Export.new(context: { export_path: 'spec/fixtures/archive/output' }).generate
```

### Components

Each component work for one Staircase with his dependencies (Sectors and Zones)

#### PdfToPng component

This component is responsible for converting every PDF files into a PNG file

#### CreateLayout component

This component is responsible for creating the Staircase layout, where the Staircases components will lie

#### ComposeGrid component

This component is responsible for composing the staircase image from the given sector blueprints

#### Annotate component

This component is responsible for adding the name of the Sector as a subtitle below of the corresponding blueprint on the layout

## Configuration

You can change the layout configuration

```
Composer.configure do |config|
  config.layout = {
    dimension: { width: 2109.0, height: 1818.0 },
    marge:     { width: 40.0,   height: 8.0    },
    footer: 32.0
  }
end
```

## Internal library

There is a bunch of internal libraries to help all the computation. See the internal documentation for everyone.

## Links

https://finalcad.atlassian.net/wiki/spaces/Plugins/pages/132448271/As+a+Plugin+user+I+want+to+create+or+update+my+zoning+with+staircase
