# encoding: utf-8
require_relative "nsudoku/version"
require_relative "nsudoku/checker"
require_relative "nsudoku/solver"

class NSudoku

  def initialize(sudoku)
    @sudoku = sudoku
    @length = @sudoku.length
    @width = Math.sqrt(@sudoku.length).to_i
    @block_width = Math.sqrt(@width).to_i
  end

  # return first correct solution for variable @sudoku
  def solution
    @solution = nil
    data = @sudoku.clone + "0"
    solver(data, -1, "0")
    @solution[0, @length] if @solution
  end

  # return result which match to all solutions of sudoku
  def solve
    NSudoku::Solver.new(@sudoku).search.sudoku
  end

private

  # Recursive solving sudoku game
  #
  # solver(data, -1, "0")
  def solver(data, position, value)
    return if @solution
    data[position] = value.to_s
    return unless NSudoku::Checker.new(data).correct?
    @solution = data.clone if position == @length - 1
    if @sudoku[position + 1] == "0"
      (1..@width).each do |value|
        solver(data, position + 1, value)
        data[position + 1] = "0"
      end
    else
      solver(data, position + 1, @sudoku[position + 1])
    end
  end

end
