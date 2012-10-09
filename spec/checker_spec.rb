# encoding: utf-8

require 'nsudoku'

describe NSudoku::Checker do

  it "row 1 has repeat value" do
    example = "0000" +
              "1202" +
              "0000" +
              "2022"
    NSudoku::Checker.new(example).repeat_in_row(1).should eql([5,7])
  end

  it "column 3 has repeat value" do
    example = "0001" +
              "1202" +
              "0003" +
              "2022"
    NSudoku::Checker.new(example).repeat_in_col(3).should eql([7,15])
  end

  it "block 3 has repeat value" do
    example = "0001" +
              "1202" +
              "0003" +
              "2022"
    NSudoku::Checker.new(example).repeat_in_block(3).should eql([14,15])
  end

  it "the array of sudoku has got at positions 5 and 7 that same value" do
    example = "0001" +
              "1202" +
              "0003" +
              "2022"
    NSudoku::Checker.new(example).repeat_in.should eql([5, 7])
  end

  it "the array of sudoku is correct" do
    example = "0001" +
              "1002" +
              "0003" +
              "2010"
    NSudoku::Checker.new(example).repeat_in.should be_nil
  end

end
