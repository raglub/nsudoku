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

describe Sudoku do

  it "should properly reverse base namber of table" do
    sudoku = Sudoku.new(EXAMPLE_II)
    sudoku.send(:table)[1][1].should eql([1])
    sudoku.send(:table)[1][0].should eql([1, 2, 3, 4, 5, 6, 7, 8, 9])
  end
end
