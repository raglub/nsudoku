# encoding: utf-8

require 'nsudoku'

EXAMPLE = [
  "012000000",
  "304052000",
  "605170000",
  "070208090",
  "920700084",
  "050906010",
  "000320908",
  "000580107",
  "000000240"].join

TABLE_EMPTY = [
  "000000000",
  "000000000",
  "000000000",
  "000000000",
  "000000000",
  "000000000",
  "000000000",
  "000000000",
  "000000000"].join

SUDOKU44 = [
  "1030",
  "4000",
  "0140",
  "3001"].join

describe NSudoku do

  it "should properly resolved game sudoku" do
    NSudoku.new(SUDOKU44).solution.should eq("1234431221433421")
  end

  it "should properly reverse base namber of table" do
    sudoku = NSudoku.new(TABLE_EMPTY)
    sudoku.send(:cell_revers_table, 1, 1, [1])
    sudoku.send(:cell_revers_table, 8, 8, [3])
    sudoku.send(:cell_revers_table, 1, 1).should eql([1])
    sudoku.send(:cell_revers_table, 1 ,0).should eql([1, 2, 3, 4, 5, 6, 7, 8, 9])
  end

  context "should properly erase values which are that same like in cell with single element" do
    it "in column (exist cell with single element)" do
      sudoku = NSudoku.new(TABLE_EMPTY)
      sudoku.send(:cell_revers_table, 3, 4, [5])
      sudoku.send(:erase_in_vertical_one, 3, 4)
      sudoku.send(:cell_revers_table, 0, 4).should eql([1, 2, 3, 4, 6, 7, 8, 9])
      sudoku.send(:cell_revers_table, 5, 4).should eql([1, 2, 3, 4, 6, 7, 8, 9])
      sudoku.send(:cell_revers_table, 8, 4).should eql([1, 2, 3, 4, 6, 7, 8, 9])
      sudoku.send(:cell_revers_table, 3, 4).should eql([5])
    end

    it "in column (don't exist cell with single element)" do
      sudoku = NSudoku.new(TABLE_EMPTY)
      sudoku.send(:erase_in_vertical_one, 3, 4)
      sudoku.send(:cell_revers_table, 5, 4).should eql([1, 2, 3, 4,5 , 6, 7, 8, 9])
      sudoku.send(:cell_revers_table, 3, 4).should eql([1, 2, 3, 4,5 , 6, 7, 8, 9])
    end

    it "in row (exist cell with single element)" do
      sudoku = NSudoku.new(TABLE_EMPTY)
      sudoku.send(:cell_revers_table, 3, 4, [5])
      sudoku.send(:erase_in_horizontal_one, 3, 4)
      sudoku.send(:cell_revers_table, 3, 2).should eql([1, 2, 3, 4, 6, 7, 8, 9])
      sudoku.send(:cell_revers_table, 3, 4).should eql([5])
    end

    it "in column (don't exist cell with single element)" do
      sudoku = NSudoku.new(TABLE_EMPTY)
      sudoku.send(:erase_in_horizontal_one, 3, 4)
      sudoku.send(:cell_revers_table, 3, 2).should eql([1, 2, 3, 4, 5, 6, 7, 8, 9])
      sudoku.send(:cell_revers_table, 3, 4).should eql([1, 2, 3, 4 ,5, 6, 7, 8, 9])
    end

    it "in block (exist cell with single element)" do
      sudoku = NSudoku.new(TABLE_EMPTY)
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

    it "in block (don't exist cell with single element)" do
      sudoku = NSudoku.new(TABLE_EMPTY)
      sudoku.send(:erase_in_block_one, 7, 3)
      sudoku.send(:cell_revers_table, 6, 2).should eql([1, 2, 3, 4 ,5, 6, 7, 8, 9])
      sudoku.send(:cell_revers_table, 5, 6).should eql([1, 2, 3, 4 ,5, 6, 7, 8, 9])

      sudoku.send(:cell_revers_table, 6, 4).should eql([1, 2, 3, 4 ,5, 6, 7, 8, 9])
      sudoku.send(:cell_revers_table, 8, 3).should eql([1, 2, 3, 4 ,5, 6, 7, 8, 9])
    end
  end

  context "select cells with two elements (rest erase)" do

    it "in block" do
      sudoku = NSudoku.new(TABLE_EMPTY)
      3.times do |row|
        3.times do |column|
          sudoku.send(:cell_revers_table, row, column, [2, 3, 4, 5, 6, 7, 9])
        end
      end

      sudoku.send(:cell_revers_table, 0, 0, [1, 5, 8])
      sudoku.send(:cell_revers_table, 2, 2, [1, 3, 8])

      sudoku.send(:cells_with_two_elements_for, "block", 0)
      sudoku.send(:cell_revers_table, 0, 0).should eql([1, 8])
      sudoku.send(:cell_revers_table, 2, 2).should eql([1, 8])
      sudoku.send(:cell_revers_table, 1, 2).should eql([2, 3, 4, 5, 6, 7, 9])
    end

    it "in column" do
      sudoku = NSudoku.new(TABLE_EMPTY)
      sudoku.send(:cell_revers_table, 0, 4, [1, 5, 8])
      sudoku.send(:cell_revers_table, 1, 4, [1, 3, 8])
      (2..8).each do |index|
        sudoku.send(:cell_revers_table, index, 4, [2, 3, 4, 5, 6, 7, 9])
      end

      sudoku.send(:cells_with_two_elements_for, "column",  4)
      sudoku.send(:cell_revers_table, 0, 4).should eql([1, 8])
      sudoku.send(:cell_revers_table, 1, 4).should eql([1, 8])
      sudoku.send(:cell_revers_table, 2, 4).should eql([2, 3, 4, 5, 6, 7, 9])
    end

    it "in row" do
      sudoku = NSudoku.new(TABLE_EMPTY)
      sudoku.send(:cell_revers_table, 4, 0, [1, 5, 8])
      sudoku.send(:cell_revers_table, 4, 1, [1, 3, 8])
      (2..8).each do |index|
        sudoku.send(:cell_revers_table, 4, index, [2, 3, 4, 5, 6, 7, 9])
      end

      sudoku.send(:cells_with_two_elements_for, "row",  4)
      sudoku.send(:cell_revers_table, 4, 0).should eql([1, 8])
      sudoku.send(:cell_revers_table, 4, 1).should eql([1, 8])
      sudoku.send(:cell_revers_table, 4, 2).should eql([2, 3, 4, 5, 6, 7, 9])
    end

  end

  it "solve whole sudoku" do
    NSudoku.new(EXAMPLE).solve.should eql("712460850394852671685170420070208596926715384050906712540320968269584137030690245")
  end
end
