require "nsudoku/version"

class NSudoku

  def initialize(data)
    @revers_table = create_revers_table(data.split(""))
  end

  def solve
    revers_table = nil
    while not revers_table == @revers_table
      revers_table = Marshal.load(Marshal.dump(@revers_table))

     9.times do |index|
        cells_with_two_elements_for('row', index)
        cells_with_two_elements_for('column', index)
        cells_with_two_elements_for('block', index)
        erase_in_horizontal_three(index)
        erase_in_vertical_three(index)
     end

      9.times do |row_index|
        9.times do |column_index|
          erase_in_vertical_one(row_index, column_index)
          erase_in_horizontal_one(row_index, column_index)
          erase_in_block_one(row_index, column_index)
        end
      end
    end
    revers_table_to_result
  end

  def show_table_pretty
     @revers_table.each do |cell|
       puts cell.inspect
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
      result[row][column] = 9.times.map{|element| element + 1} if cell == 0
    end
    return result
  end

  # revers table @revers_table into string where cell [n] return n and [a1, a2, ..., ak] return 0
  def revers_table_to_result
    result = ""
    @revers_table.flatten(1).each do |element|
      result << (element.size == 1 ? element.first.to_s : "0")
    end
    result
  end


  def positions_for(type, index0, index1)
    case type
    when 'column'
      return {
        row: index0,
        column: index1
      }
    when 'row'
      return {
        row: index0,
        column: index1
      }
    when 'block'
      return {
        row: (index0/3)*3 + index1/3,
        column: (index0%3)*3 + index1%3
      }
    end
  end

  def positions_of_values(kind, value)
    result = {}
     row, column = nil, nil
     9.times do |index|
      case kind
      when 'column'
        row = index
        column = value
      when 'row'
        row = value
        column = index
      when 'block'
        row = (value/3)*3 + index/3
        column = (value%3)*3 + index%3
      end
      next if row.nil? or column.nil?
      @revers_table[row][column].each do |value|
        result[value] ||= []
        result[value] << index
      end
    end
    result
  end

  # erase values in vertical, which are that same like value from positnio row, column
  # type: "block", "row","column"
  def cells_with_two_elements_for(type, index)
  only_two_positions = positions_of_values(type, index).select {|k,v| v.length == 2}
    result = {}
    only_two_positions.each do |value, positions|
      result[positions] ||= []
      result[positions] << value
    end
    result.each do |key, value|
      if value.size == 2
        if type == 'block'
          positions = positions_for('block', index, key[0])
          @revers_table[positions[:row]][positions[:column]] = value.clone
          positions = positions_for('block', index, key[1])
          @revers_table[positions[:row]][positions[:column]] = value.clone
        end
        if type == 'row'
          @revers_table[index][key[0]] = value.clone
          @revers_table[index][key[1]] = value.clone
        end
        if type == 'column'
          @revers_table[key[0]][index] = value.clone
          @revers_table[key[1]][index] = value.clone
        end
      end
    end
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

  # erase values in vertical, which are that same like value from positnio row, column
  def erase_in_vertical_three(column)
    positions_of_values('column', column).each do |value, positions|
      @revers_table[positions.first][column] = [value] if positions.size == 1
    end
  end

  # erase values in horizontal, which are that same like value from positnio row, column
  def erase_in_horizontal_three(row)
    positions_of_values('row', row).each do |value, positions|
      @revers_table[row][positions.first] = [value] if positions.size == 1
    end
  end

  def cell_revers_table(row, column, value = nil)
    @revers_table[row][column] = value unless value.nil?
    @revers_table[row][column]
  end

end
