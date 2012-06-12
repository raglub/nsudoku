require "sudoku/version"

class Sudoku

  def initialize(data)
    @table = create_table(data)
  end

  # table = [[[1, 2, 3, 4, 5], [], ..., []],
  #          [[],                  ..., []],
  #                    ...
  #          [[],                  ..., []]
  #         ]
  def create_table(data)
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

private

  # erase values in vertical, which are that same like value from positnio row, column
  def erase_in_vertical(row, column)

  end

  def table
    @table
  end

  def table=(table)
    @table = table
  end

end
