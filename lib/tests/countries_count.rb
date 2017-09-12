require 'securerandom'

def solution(a)
  CountriesCount.new.solution(a)
end

class CountriesCount
  def solution(a)
    Compose.new(raw_matrix: a).analyze.compositions
  end
end

class Cell
  attr_reader :row, :column, :color, :position
  attr_accessor :taken

  def initialize(row:, column:, color:)
    @row      = row
    @column   = column
    @color    = color
    @position = Position.new(row: row, column: column)
  end

  def inspect
    "[#{row}, #{column}, #{color}]"
  end
end

class Convert
  attr_reader :cells, :row_rang, :column_rang

  def initialize(matrix:)
    @matrix         = matrix
    @row_rang    = (0..(matrix.length - 1))
    @column_rang = (0..(matrix.first.length - 1))
    @cells = []
  end

  def call
    row_rang.each do |row_index|
      column_rang.each do |column_index|
        cells << Cell.new(row: row_index, column: column_index, color: @matrix[row_index][column_index])
      end
    end

    self
  end
end

class Position
  attr_reader :row, :column

  def initialize(row:, column:)
    @row    = row
    @column = column
  end
end

class Compose
  attr_reader :blocks, :cells

  def initialize(raw_matrix:)
    converter     = Convert.new(matrix: raw_matrix).call
    @cells        = converter.cells
    @row_rang     = converter.row_rang
    @column_rang  = converter.column_rang
    @blocks       = {}
  end

  def compositions
    blocks.keys.size
  end

  def analyze
    count = 1
    cells.each do |cell|
      next if cell.taken

      found_cells = find_border_cells(cell) # Find all contiguous cells

      blocks[count] = found_cells.flatten
      blocks[count] << cell if blocks[count].empty? # No contiguous cells, add the cell alone

      count += 1
    end

    self
  end

  def find_border_cells(cell, found_cells = [])
    [:north, :south, :west, :east].each do |cardinate|
      send(:"find_#{cardinate}_cells", cell.position, cell.color).each do |found_cell|
        found_cells << found_cell
        find_border_cells(found_cell, found_cells)
      end
    end

    found_cells
  end

  def find_cells(position, color, found_cells=[])
    cell_found = cells.detect { |entry| entry.row == position.row && entry.column == position.column }

    return [] unless cell_found
    return [] if cell_found.taken

    if color == cell_found.color
      found_cells << cell_found
      cell_found.taken = true

      send(__callee__, position, color, found_cells)
    end

    found_cells
  end

  def find_north_cells(position, color, found_cells=[])
    new_row = position.row - 1
    return [] unless row_into_the_matrix?(new_row)

    new_position = Position.new(row: new_row, column: position.column)
    find_cells(new_position, color, found_cells)
  end

  def find_south_cells(position, color, found_cells=[])
    new_row = position.row + 1
    return [] unless row_into_the_matrix?(new_row)

    new_position = Position.new(row: new_row, column: position.column)
    find_cells(new_position, color, found_cells)
  end

  def find_west_cells(position, color, found_cells=[])
    new_column = position.column - 1
    return [] unless column_into_the_matrix?(new_column)

    new_position = Position.new(row: position.row, column: new_column)
    find_cells(new_position, color, found_cells)
  end

  def find_east_cells(position, color, found_cells=[])
    new_column = position.column + 1
    return [] unless column_into_the_matrix?(new_column)

    new_position = Position.new(row: position.row, column: new_column)
    find_cells(new_position, color, found_cells)
  end

  def row_into_the_matrix?(index)
    @row_rang.include?(index)
  end

  def column_into_the_matrix?(index)
    @column_rang.include?(index)
  end
end
