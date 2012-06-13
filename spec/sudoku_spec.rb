# encoding: utf-8

require 'sudoku'

EXAMPLE = ["012000000",
           "304052000",
           "605170000",
           "070208090",
           "920700084",
           "050906010",
           "000320908",
           "000580107",
           "000000240"].join.split("")

EXAMPLE_II =["000000000",
             "010000000",
             "000000000",
             "000000000",
             "000000000",
             "000000000",
             "000000000",
             "000000000",
             "000000003"].join.split("")

TABLE_EMPTY = [
  "000000000",
  "000000000",
  "000000000",
  "000000000",
  "000000000",
  "000000000",
  "000000000",
  "000000000",
  "000000000"].join.split("")

describe Sudoku do

  it "should properly reverse base namber of table" do
    sudoku = Sudoku.new(EXAMPLE_II)
    sudoku.send(:cell_revers_table, 1, 1).should eql([1])
    sudoku.send(:cell_revers_table, 1 ,0).should eql([1, 2, 3, 4, 5, 6, 7, 8, 9])
  end

  context "operations in vertical" do
    it "should properly erase values which are that same like in cell" do
      sudoku = Sudoku.new(TABLE_EMPTY)
      sudoku.send(:cell_revers_table, 3, 4, [5])
      sudoku.send(:erase_in_vertical_one, 3, 4)
      sudoku.send(:cell_revers_table, 5, 4).should eql([1, 2, 3, 4, 6, 7, 8, 9])
      sudoku.send(:cell_revers_table, 3, 4).should eql([5])
    end

    it "don't should erase values" do
      sudoku = Sudoku.new(TABLE_EMPTY)
      sudoku.send(:erase_in_vertical_one, 3, 4)
      sudoku.send(:cell_revers_table, 5, 4).should eql([1, 2, 3, 4,5 , 6, 7, 8, 9])
      sudoku.send(:cell_revers_table, 3, 4).should eql([1, 2, 3, 4,5 , 6, 7, 8, 9])
    end
  end

  context "operations in horizontal" do
    it "should properly erase values which are that same like in cell" do
      sudoku = Sudoku.new(TABLE_EMPTY)
      sudoku.send(:cell_revers_table, 3, 4, [5])
      sudoku.send(:erase_in_horizontal_one, 3, 4)
      sudoku.send(:cell_revers_table, 3, 2).should eql([1, 2, 3, 4, 6, 7, 8, 9])
      sudoku.send(:cell_revers_table, 3, 4).should eql([5])
    end

    it "don't should erase values" do
      sudoku = Sudoku.new(TABLE_EMPTY)
      sudoku.send(:erase_in_horizontal_one, 3, 4)
      sudoku.send(:cell_revers_table, 3, 2).should eql([1, 2, 3, 4, 5, 6, 7, 8, 9])
      sudoku.send(:cell_revers_table, 3, 4).should eql([1, 2, 3, 4 ,5, 6, 7, 8, 9])
    end
  end

  context "operations in block" do
    it "should properly erase values which are that are that same like in cell" do
      sudoku = Sudoku.new(TABLE_EMPTY)
      sudoku.send(:cell_revers_table, 7, 3, [8])
      sudoku.send(:erase_in_block_one, 7, 3)
      sudoku.send(:cell_revers_table, 6, 2).should eql([1, 2, 3, 4 ,5, 6, 7, 8, 9])
      sudoku.send(:cell_revers_table, 5, 6).should eql([1, 2, 3, 4 ,5, 6, 7, 8, 9])
      sudoku.send(:cell_revers_table, 5, 3).should eql([1, 2, 3, 4 ,5, 6, 7, 8, 9])
      sudoku.send(:cell_revers_table, 7, 6).should eql([1, 2, 3, 4 ,5, 6, 7, 8, 9])

      sudoku.send(:cell_revers_table, 6, 4).should eql([1, 2, 3, 4 ,5, 6, 7, 9])
      sudoku.send(:cell_revers_table, 8, 3).should eql([1, 2, 3, 4 ,5, 6, 7, 9])
      sudoku.send(:cell_revers_table, 8, 5).should eql([1, 2, 3, 4 ,5, 6, 7, 9])
      sudoku.send(:cell_revers_table, 7, 3).should eql([8])
    end

    it "don't should erase values" do
      sudoku = Sudoku.new(TABLE_EMPTY)
      sudoku.send(:erase_in_block_one, 7, 3)
      sudoku.send(:cell_revers_table, 6, 2).should eql([1, 2, 3, 4 ,5, 6, 7, 8, 9])
      sudoku.send(:cell_revers_table, 5, 6).should eql([1, 2, 3, 4 ,5, 6, 7, 8, 9])

      sudoku.send(:cell_revers_table, 6, 4).should eql([1, 2, 3, 4 ,5, 6, 7, 8, 9])
      sudoku.send(:cell_revers_table, 8, 3).should eql([1, 2, 3, 4 ,5, 6, 7, 8, 9])
    end
  end

  it "solve" do
    sudoku = Sudoku.new(EXAMPLE)
    sudoku.solve
  end
end
