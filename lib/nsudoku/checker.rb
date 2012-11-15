# encoding: utf-8

class NSudoku
  class Checker
    def initialize(sudoku)
      @sudoku = sudoku
      @width = Math.sqrt(@sudoku.length).to_i
      @block_width = Math.sqrt(@width).to_i
    end

    def correct?
      return true if repeat_in.nil?
      false
    end

    def repeat_in
      @width.times do |index|
        result = repeat_in_row(index)
        return result if result
        result = repeat_in_col(index)
        return result if result
        result = repeat_in_block(index)
        return result if result
      end
      nil
    end

    # check whether values repeated in row
    def repeat_in_row(row)
      sub_sudoku = @sudoku[row*@width..(row+1)*@width-1].split("").map{|element| element.to_i}
      result = []
      @width.times do |col|
        if sub_sudoku.count(col+1) > 1
          sub_sudoku.each_with_index do |element, index|
            result << row*@width + index if element == col+1
          end
          return result
        end
      end
      nil
    end

    # check whether values repeated in col
    def repeat_in_col(col)
      sub_sudoku = []
      @width.times do |index|
        sub_sudoku << @sudoku[index*@width + col].to_i
      end
      result = []
      @width.times do |row|
        if sub_sudoku.count(row+1) > 1
          sub_sudoku.each_with_index do |element, index|
            result << index*@width + col if element == row+1
          end
          return result
        end
      end
      nil
    end

    # check whether values repeated in block
    def repeat_in_block(block)
      sub_sudoku = []
      @width.times do |index|
        sub_sudoku << @sudoku[position_for_block(block, index)].to_i
      end

      result = []
      @width.times do |sub_block|
        if sub_sudoku.count(sub_block+1) > 1
          sub_sudoku.each_with_index do |element, index|
            result << position_for_block(block, index) if element == sub_block+1
          end
          return result
        end
      end
      nil
    end

    def position_for_block(block, sub_block)
      first_col = block.modulo(@block_width)*@block_width
      first_row = block.div(@block_width)*@block_width
      col = first_col + sub_block.modulo(@block_width)
      row = first_row + sub_block.div(@block_width)
      row*@width + col
    end
  end
end
