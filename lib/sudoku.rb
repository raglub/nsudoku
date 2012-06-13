require "sudoku/version"

class Sudoku

  def initialize(data)
    @revers_table = create_revers_table(data)
  end

  def solve
    revers_table = nil
    while not revers_table == @revers_table
      9.times do |row_index|
        9.times do |column_index|
          erase_in_vertical_one(row_index, column_index)
          erase_in_horizontal_one(row_index, column_index)
          erase_in_block_one(row_index, column_index)
          puts "row_index : #{row_index}  column_index: #{column_index}"
        end
      end
      revers_table = Marshal.load(Marshal.dump(@revers_table))
    end
  end

private

  # table = [[[1, 2, 3, 4, 5], [], ..., []],
  #          [[],                  ..., []],
  #                    ...
  #          [[],                  ..., []]
  #         ]
  def create_revers_table(data)
    result = 9.times.map{|row_element| 9.times.map{|col_element| []}}
    data.each_with_index do |cell, index|
      column = index % 9
      row = (index - column)/9 % 9
      cell = cell.to_i
      result[row][column] = [cell]
      result[row][column] = 9.times.map{|element| element+1} if cell == 0
    end
    return result
  end

  # erase values in vertical, which are that same like value from positnio row, column
  def erase_in_vertical_one(row, column)
    return unless @revers_table[row][column].size == 1
    cell = @revers_table[row][column][0]
    9.times do |index|
      @revers_table[index][column].delete(cell) unless index == row
    end
  end

  # erase values in hozizontal, which are that same like value from positnio row, column
  def erase_in_horizontal_one(row, column)
    return unless @revers_table[row][column].size == 1
    cell = @revers_table[row][column][0]
    9.times do |index|
      @revers_table[row][index].delete(cell) unless index == column
    end
  end

  # erase values in block, which are that same like value from positnio row, column
  def erase_in_block_one(row, column)
    return unless @revers_table[row][column].size == 1
    cell = @revers_table[row][column][0]
    first_row_block = (row/3)*3
    first_column_block = (column/3)*3
    3.times do |row_index|
      row_block = first_row_block + row_index
      3.times do |column_index|
        column_block = first_column_block + column_index
        @revers_table[row_block][column_block].delete(cell) unless row_block == row and column_block == column
      end
    end
  end

  def cell_revers_table(row, column, value = nil)
    @revers_table[row][column] = value unless value.nil?
    @revers_table[row][column]
  end

end
