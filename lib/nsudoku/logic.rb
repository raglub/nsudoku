# encoding: utf-8

class NSudoku
  class Logic

    attr_accessor :revers

    def initialize(sudoku)
      @sudoku = sudoku
      @width = Math.sqrt(sudoku.length).to_i
      @block_width = Math.sqrt(@width).to_i
      @revers = create_revers(@sudoku.split(""))
    end

    def create_revers(data)
      @revers, index = raw_revers, 0
      @revers.each_with_index do |row, row_index|
        row.each_with_index do |col, col_index|
          cell = data[index]
          @revers[row_index][col_index] = [cell.to_i] if cell =~ /^[1-9]$/
          index += 1
        end
      end
    end

    # revers table @revers_table into string where cell [n] return n and [a1, a2, ..., ak] return 0
    def sudoku
      result = ""
      @revers.flatten(1).each do |element|
        result << (element.size == 1 ? element.first.to_s : "0")
      end
      result
    end

    # change positions: external position of block for sudoku and
    # internal position of block into array [row_position, column_position]
    def block_position(external, internal)
      [
        (external / @block_width) * @block_width + internal / @block_width,
        (external % @block_width) * @block_width + internal % @block_width
      ]
    end

    def block_positions_values(external)
      result = {}
      @width.times do |internal|
        row, column = block_position(external, internal)
        @revers[row][column].each { |value| (result[value] ||= []) << [row, column] }
      end
      result
    end

    def row_positions_values(row)
      result = {}
      @width.times do |column|
        @revers[row][column].each { |value| (result[value] ||= []) << column }
      end
      result
    end

    def column_positions_values(column)
      result = {}
      @width.times do |row|
        @revers[row][column].each { |value| (result[value] ||= []) << row }
      end
      result
    end

    # erase values in vertical, which are that same like value from positnio row, column
    def one_element_vertical(column)
      column_positions_values(column).each do |value, positions|
        @revers[positions.first][column] = [value] if positions.size == 1
      end
      self
    end

    # erase values in horizontal, which are that same like value from positnio row, column
    def one_element_horizontal(row)
      row_positions_values(row).each do |value, positions|
        @revers[row][positions.first] = [value] if positions.size == 1
      end
      self
    end

    # erase values in block, which are that same like value from positnio row, column
    def one_element_block(row)
      block_positions_values(row).each do |value, positions|
        horizontal = positions[0][0]
        vertical = positions[0][1]
        @revers[horizontal][vertical] = [value] if positions.size == 1
      end
      self
    end

    # erase values in block, which are that same like value from positnio row, column
    def two_elements_block(index)
      result = {}
      only_two_positions = block_positions_values(index).select {|k,v| v.length == 2}
      only_two_positions.each { |value, positions| (result[positions] ||= []) << value }
      result.each do |positions, value|
        next unless value.size == 2
        @revers[positions[0][0]][positions[0][1]] = value.clone
        @revers[positions[1][0]][positions[1][1]] = value.clone
      end
      self
    end

    # erase values in vertical, which are that same like value from positnio row, column
    def two_elements_column(column)
      result = {}
      only_two_positions = row_positions_values(column).select {|k,v| v.length == 2}
      only_two_positions.each { |value, positions| (result[positions] ||= []) << value }
      result.each do |positions, value|
        next unless value.size == 2
        @revers[positions[0]][column] = value.clone
        @revers[positions[1]][column] = value.clone
      end
      self
    end

    # erase values in row, which are that same like value from positnio row, column
    def two_elements_row(row)
      result = {}
      only_two_positions = column_positions_values(row).select {|k,v| v.length == 2}
      only_two_positions.each { |value, positions| (result[positions] ||= []) << value }
      result.each do |positions, value|
        next unless value.size == 2
        @revers[row][positions[0]] = value.clone
        @revers[row][positions[1]] = value.clone
      end
      self
    end

    # erase values in vertical, which are that same like value from positnio row, column
    def erase_elements_row(row, column)
      return unless @revers[row][column].size == 1
      cell = @revers[row][column][0]
      @width.times do |index|
        @revers[index][column].delete(cell) unless index == row
      end
      self
    end

    # erase values in hozizontal, which are that same like value from positnio row, column
    def erase_elements_column(row, column)
      return unless @revers[row][column].size == 1
      cell = @revers[row][column][0]
      @width.times do |index|
        @revers[row][index].delete(cell) unless index == column
      end
      self
    end

    # erase values in block, which are that same like value from positnio row, column
    def erase_elements_block(row, column)
      return unless @revers[row][column].size == 1
      cell = @revers[row][column][0]
      block_positions(row, column).each do |horizontal, vertical|
        @revers[horizontal][vertical].delete(cell) unless horizontal == row and vertical == column
      end
      self
    end

    def block_positions(row, column)
      row_block = (row / @block_width) * @block_width
      column_block = (column / @block_width) * @block_width
      (0...@width).to_a.map { |index| [row_block + index / @block_width, column_block + index % @block_width] }
    end

  private

    # @width = 4
    # cell = [1, 2, 3, 4]
    # return  [[cell, cell, cell, cell],
    #          [cell, cell, cell, cell],
    #          [cell, cell, cell, cell],
    #          [cell, cell, cell, cell]]
    def raw_revers
      (1..@width).to_a.map do
        (1..@width).to_a.map do
          (1..@width).to_a
        end
      end
    end

  end
end
