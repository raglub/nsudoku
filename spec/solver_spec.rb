# encoding: utf-8

require 'nsudoku'

EXAMPLE = [
  "1004",
  "0302",
  "0143",
  "3020"].join

# REVERS = [
#   [[1],          [1, 2, 3, 4], [1, 2, 3, 4], [4]],
#   [[1, 2, 3, 4], [2],          [1, 2, 3, 4], [1]],
#   [[1, 2, 3, 4], [1],          [4],          [3]],
#   [[2],          [1, 2, 3, 4], [1],          [1, 2, 3, 4]]
# ]

describe NSudoku do

  before do
    @logic = NSudoku::Solver.new(EXAMPLE)
  end

  it "can generate reverse of sudoku" do
    @logic.revers[0][1].should eql([1, 2, 3, 4])
    @logic.revers[3][3].inspect
  end

  it "can get result" do
    @logic.sudoku.should eql(EXAMPLE)
  end

  context "can erase that same elements in" do
    it "column" do
      @logic.set_vector(:column, 3, [[1, 3], [1, 2, 3, 4], [1, 3, 4], [4]])
      @logic.only_one(:column, 3)
      @logic.get_vector(:column, 3).should eq([[1, 3], [1, 2, 3], [1, 3], [4]])
    end

    it "row" do
      @logic.set_vector(:column, 3, [[1, 3], [1, 2, 3, 4], [1, 3, 4], [4]])
      @logic.only_one(:column, 3)
      @logic.get_vector(:column, 3).should eq([[1, 3], [1, 2, 3], [1, 3], [4]])
    end

    it "block" do
      @logic.set_vector(:block, 1, [[1, 2, 3], [2], [1, 2, 3, 4], [4]])
      @logic.only_one(:block, 1)
      @logic.get_vector(:block, 1).should eq([[1, 3], [2], [1, 3], [4]])
    end
  end

  context "can choos only one value in elements for" do
    it "vertical situation" do
      @logic.set_vector(:column, 2, [[1, 3], [1, 2, 3, 4], [1, 3, 4], [4]])
      @logic.search_single(:column, 2)
      @logic.get_vector(:column, 2).should eq([[1, 3], [2], [1, 3, 4], [4]])
    end

    it "horizontal situation" do
      @logic.set_vector(:row, 2, [[1, 3], [1, 2, 3, 4], [1, 3, 4], [4]])
      @logic.search_single(:row, 2)
      @logic.get_vector(:row, 2).should eq([[1, 3], [2], [1, 3, 4], [4]])
    end

    it "block situation" do
      @logic.set_vector(:block, 2, [[1, 3], [1, 2, 3, 4], [1, 3, 4], [4]])
      @logic.search_single(:block, 2)
      @logic.get_vector(:block, 2).should eq([[1, 3], [2], [1, 3, 4], [4]])
    end
  end

  context "can choose only two values in elements for" do
    it "vertical situation" do
      @logic.set_vector(:column, 2, [[1], [1, 2, 3, 4], [1, 2, 3, 4], [4]])
      @logic.search_pair(:column, 2)
      @logic.get_vector(:column, 2).should eq([[1], [2, 3], [2, 3], [4]])
    end

    it "horizontal situation" do
      @logic.set_vector(:row, 3, [[3], [1, 2, 3, 4], [1, 2, 4], [4]])
      @logic.search_pair(:row, 3)
      @logic.get_vector(:row, 3).should eq([[3], [1, 2], [1, 2], [4]])
    end

    it "block situation" do
      @logic.set_vector(:block, 0, [[1], [1, 2, 3, 4], [1, 2, 3, 4], [4]])
      @logic.search_pair(:block, 0)
      @logic.get_vector(:block, 0).should eq([[1], [2, 3], [2, 3], [4]])
    end
  end

  it "can solve the sudoku" do
    NSudoku::Solver.new(EXAMPLE).search.sudoku.should eql(
      "1234" +
      "4312" +
      "2143" +
      "3421"
    )
  end

end
