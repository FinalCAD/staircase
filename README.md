# staircase

Service to create Staircase

## What's the purpose of this service

For some internal purpose we need to perform some manipulations on generated archive of blueprints from plugin like AutoCAD Plugin or Revit Plugin

Basically those plugins know how produced Sectors and Zones, but for some specific projects we need another type composed by several Sectors into one, here a Staircase

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

A Staircase can be see as a matrix, this matrix is the composition of sectors, it can have a variable of number of columns and rows

### Models architecture

Too simplify the manipulation of those different files, the library load in memory those files as model

-- Staircase
 |-- Sectors
   |-- Zones

Like that we have all we need gathered in one Staircase model.

### Load model in memory

To load the models we need to give a input directory where the original files can be found

`Composer::Import::Dir` is responsible to instancy for every file that match our requirement, it's really basic

`Composer::Import::Instantiate` is responsible to instantiate the appropriate model, a `staircase`, `sector` or `zone` and put it where is belong.

the instantiated model is really simple, you can safely overriding it

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

Once the model loaded you can access it memory

```
registry = Composer::Stores::Registry.instance
registry.inputs
```

You can play easily with every files concerning a Staircase

```
registry.staircases['Staircase Name 1'].sectors['R+1'].zones['Logement 12-11-=-Architecte'].path(:pdf).to_s
=> "spec/fixtures/archive/input/Staircases/Staircase Name 1/Zones/R+1/Logement 12-11-=-Architecte.pdf"
```

## Exporting

Basically the export it a suite of manipulations

You can invoke the exportation like :

```
Composer::Export.new.generate
```

### Exporting components

Each component work with one Staircase

#### PdfToPng component

This component its responsible to take every PDF files of every Sectors and every Zones of the given Staircase and convert it to a PNG file

#### PngReduce component

This component its responsible to take every PNG files of every Sectors of the given Staircase and resize to fit the expected grid

#### ComposeGrid component

This component its responsible to compose the staircase image from the given sectors blueprints provided

## Internal library

### Grid

`Composer::Lib::Grid` take a number of images, basically the number of sectors and get the matrix needed

### Dimension

`Composer::Lib::Dimension` is a simple value object to carry one height and width

### Size

`Composer::Lib::Size` take as arguments, a Grid, the expected image dimension, and the marges

### Point

`Composer::Lib::Point` is a simple value object to carry one x and y

### Cursor

`Composer::Lib::Cursor` take as arguments the matrix dimensions and can give the next position of the matrix cell through the `move` method

### Position

`Composer::Lib::Position` take as arguments the image and marge dimensions and can give the position require for a specific cell of the matrix

## Links

https://finalcad.atlassian.net/wiki/spaces/Plugins/pages/132448271/As+a+Plugin+user+I+want+to+create+or+update+my+zoning+with+staircase
