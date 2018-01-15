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
 |-- Sectors
   |-- Zones
```

Like that we have all we need to be gathered in one Staircase model.

### Load model in memory

To load the models, we need to give an input directory where the original files can be found

`Composer::Import::Dir` is responsible for creating the instance for every file that matches our requirement, it's really basic

`Composer::Import::Instantiate` is responsible for instantiating the appropriate model, a `Staircase`, `Sector` or `Zone` and put it where is belong.

the instantiated model is straightforward; you can safely overriding it

```
class MyModel < Composer::Model
  def skip?
    !source_path.match(/^Staircases/)
  end
end
```

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

### Playing with Models

Once the model is loaded, you can access it in memory

```
registry = Composer::Stores::Registry.instance
registry.models
```

You can play easily with every file concerning a Staircase through their names

```
registry.staircases['Staircase Name 1'].sectors['R+1'].zones['Logement 12-11-=-Architecte'].path(:pdf).to_s
=> "spec/fixtures/archive/input/Staircases/Staircase Name 1/Zones/R+1/Logement 12-11-=-Architecte.pdf"
```

## Exporting

Basically, the export is a suite of manipulations

You can invoke the exportation like :

```
Composer::Export.new.generate
```

### Exporting components

Each component work for one Staircase

#### PdfToPng component

This component is responsible for taking every PDF files of every Sectors and every Zones of the given Staircase and converting it to a PNG file

#### CreateLayout component

This component is responsible for creating the Staircase layout

#### ComposeGrid component

This component is responsible for composing the staircase image from the given sector blueprints

#### Annotate component

This component is responsible for adding the name of the Sector as a subtitle below of the corresponding blueprint on the layout

## Internal library

### Grid

`Composer::Lib::Grid` take some images, basically the number of sectors and get the resulting matrix

### Dimension

`Composer::Lib::Dimension` is a simple value object to carry height and width

### Size

`Composer::Lib::Size` take as arguments, a Grid, the layout dimension, form that it provides the image dimension needed of the blueprints

### Point

`Composer::Lib::Point` is a simple value object to carry one x and y

### Cursor

`Composer::Lib::Cursor` take as arguments the matrix dimensions and can give the next position of the matrix cell through the `move` method

### SafePath

`Composer::Lib::SafePath` can generate a path with a given extension and escape the path properly for ImageMagick

## Links

https://finalcad.atlassian.net/wiki/spaces/Plugins/pages/132448271/As+a+Plugin+user+I+want+to+create+or+update+my+zoning+with+staircase
