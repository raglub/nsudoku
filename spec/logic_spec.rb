# encoding: utf-8

require 'nsudoku'

EXAMPLE = [
  "1004",
  "0201",
  "0143",
  "2010"].join

# REVERS = [
#   [[1],          [1, 2, 3, 4], [1, 2, 3, 4], [4]],
#   [[1, 2, 3, 4], [2],          [1, 2, 3, 4], [1]],
#   [[1, 2, 3, 4], [1],          [4],          [3]],
#   [[2],          [1, 2, 3, 4], [1],          [1, 2, 3, 4]]
# ]

REVERS = [
  [[3],          [1, 2, 3, 4], [1, 2, 4],    [4]],
  [[1, 2, 4],    [2],          [1, 2, 3, 4], [1]],
  [[1, 2, 3],    [1, 2, 4],    [4],          [3]],
  [[4],          [3, 4],       [1],          [1, 2, 3, 4]]
]

describe NSudoku do

  before do
    @logic = NSudoku::Logic.new(EXAMPLE)
  end

  it "can generate reverse of sudoku" do
    @logic.revers[0][1].should eql([1, 2, 3, 4])
    @logic.revers[3][3].inspect
  end

  it "can get result" do
    @logic.sudoku.should eql(EXAMPLE)
  end

  it "can erase that same elements in column" do
    @logic.erase_elements_column(0, 0).revers[0][1].should eql([2, 3, 4])
  end

  it "can erase that same elements in row" do
    @logic.erase_elements_row(2, 2).revers[1][2].should eql([1, 2, 3])
  end

  it "can erase that same elements in block" do
    @logic.erase_elements_block(2, 2).revers[3][3].should eql([1, 2, 3])
  end

  it "can choos only one value in elements for vertical situation" do
    @logic.revers = REVERS
    @logic.one_element_vertical(2).revers[1][2].should eql([3])
  end

  it "can choos only one value in elements for horizontal situation" do
    @logic.revers = REVERS
    @logic.one_element_horizontal(2).revers[1][2].should eql([3])
  end

  it "can choos only one value in elements for block situation" do
    @logic.revers = REVERS
    @logic.one_element_block(2).revers[1][2].should eql([3])
  end

  it "can choos only two values in elements for block situation" do
    @logic.revers = REVERS
    @logic.two_elements_block(2).revers[2][0].should eql([1, 2])
    @logic.revers[2][1].should eql([1, 2])
  end

  it "can choos only two values in elements for vertical situation" do
    @logic.revers = REVERS
    @logic.two_elements_column(0).revers[1][0].should eql([1, 2])
    @logic.revers[2][0].should eql([1, 2])
  end

  it "can choos only two values in elements for horizontal situation" do
    @logic.revers = REVERS
    @logic.two_elements_row(2).revers[2][0].should eql([1, 2])
    @logic.revers[2][1].should eql([1, 2])
  end

end
