# encoding: utf-8

class NSudoku
  class Solver

    attr_accessor :revers

    def initialize(sudoku)
      @sudoku = sudoku
      @width = Math.sqrt(sudoku.length).to_i
      @block_width = Math.sqrt(@width).to_i
      @revers = create_revers(@sudoku.split(""))
    end

    # search result of sudoku
    def search
      revers = nil
      while not revers == @revers
        revers = Marshal.load(Marshal.dump(@revers))
        @width.times do |index|
          [:row, :column, :block].each do |type|
            search_pair(type, index)
            search_single(type, index)
            only_one(type, index)
          end
        end
      end
      self
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

    # revers table @revers into string where cell [n] return n and [a1, a2, ..., ak] return 0
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

    # get vector values for row, column or block from variable @revers
    def get_vector(type, index)
      result = []
      case type
      when :row
        result = @revers[index]
      when :column
        result = @revers.map{ |element| element[index] }
      when :block
        @width.times do |block|
          row, column = block_position(index, block)
          result << @revers[row][column]
        end
      end
      result
    end

    # get vector values for row, column or block from variable @revers
    def set_vector(type, index, vector)
      case type
      when :row
        @revers[index] = vector
      when :column
        @width.times do |row|
          @revers[row][index] = vector[row]
        end
      when :block
        @width.times do |block|
          row, column = block_position(index, block)
          @revers[row][column] = vector[block]
        end
      end
    end

    def positions_values(vector)
      result = {}
      vector.each_with_index do |values, index|
        values.each do |value|
          (result[value] ||= []) << index
        end
      end
      result
    end

    def only_two_positions(vector)
      result = {}
      positions_values(vector).select do |value, positions|
        positions.length == 2
      end.each do |value, positions|
        (result[positions] ||= []) << value
      end
      result
    end

    # if vector (row, column or block) has got two cells like this [n1, n2, n3] and [n1, n2, n4]
    # and variables n1, n2 don't exist in other cells of vector than two cells should be equal [n1, n2].
    # [[1, 4], [2, 4, 1, 3], [1, 2, 4], [4]] #=> [[1, 4], [2, 4], [2, 4], [4]]
    def search_pair(type, index)
      vec = get_vector(type, index)
      only_two_positions(vec).each do |positions, value|
        next unless value.size == 2
        vec[positions[0]] = value.clone
        vec[positions[1]] = value.clone
      end
      set_vector(type, index, vec)
    end

    # if vector (row, column or block) has got cell like this [n1, n2, ..., nk]
    # and variable ni exist only one in all vector than cell should be equal [ni].
    # [[1, 2, 3, 4], [2, 4], [1, 2, 4], [1, 4]] #=> [[3], [2, 4], [1, 2, 4], [1, 4]]
    def only_one(type, index)
      vec = get_vector(type, index)
      vec.each_with_index do |values, position|
        next unless values.size == 1
        cell = values.first
        @width.times do |sub_position|
          vec[sub_position].delete(cell) unless sub_position == position
        end
      end
      set_vector(type, index, vec)
    end

    # if vector (row, column or block) has got cell like this [n1]
    # than should be erase value n1 from rest of cells.
    # [[1, 2, 3, 4], [2], [1, 2, 4], [1, 4]] #=> [[1, 3, 4], [2], [1, 4], [1, 4]]
    def search_single(type, index)
      vec = get_vector(type, index)
      positions_values(vec).each do |value, positions|
        vec[positions.first] = [value] if positions.size == 1
      end
      set_vector(type, index, vec)
    end

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
