# encoding: utf-8

require 'nsudoku'

SUDOKU99 = [
  "012000000",
  "304052000",
  "605170000",
  "070208090",
  "920700084",
  "050906010",
  "000320908",
  "000580107",
  "000000240"].join

SUDOKU44 = [
  "1030",
  "4000",
  "0140",
  "3001"].join

describe NSudoku do

  it "should properly resolved game sudoku" do
    NSudoku.new(SUDOKU44).solution.should eq("1234431221433421")
    NSudoku.new(SUDOKU99).solution.should eq("712463859394852671685179423173248596926715384458936712541327968269584137837691245")
  end

  it "should solve game sudoku" do
    NSudoku.new(SUDOKU44).solve.should eq("1234431221433421")
    NSudoku.new(SUDOKU99).solve.should eql("712460850394852671685170420070208596926715384050906712540320968269584137030690245")
  end
end
