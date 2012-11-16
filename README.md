# Sudoku

This gem solves puzzle game sudoku (n^2, n^2), for example (3^2, 3^2) = (9, 9) or (4, 4)

## Installation

Add this line to your application's Gemfile:

    > gem 'nsudoku'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install nsudoku

## Usage

Usage class NSudoku for example:

    SUDOKU = [
      "012000000",
      "304052000",
      "605170000",
      "070208090",
      "920700084",
      "050906010",
      "000320908",
      "000580107",
      "000000240"
    ].join

Solve the sudoku game

Result which match to all solutions of SUDOKU (if sample has got more than one result)

    NSudoku.new(SUDOKU).solve    #=> "712460850394852671685170420070208596926715384050906712540320968269584137030690245"

First correct solution for variable SUDOKU

    NSudoku.new(SUDOKU).solution #=> "712463859394852671685179423173248596926715384458936712541327968269584137837691245"

You can solve sudoku (4, 4)

    SUDOKU44 = [
      "1030",
      "4000",
      "0140",
      "3001"
    ].join

    NSudoku.new(SUDOKU44).solution #=> "1234431221433421"
    NSudoku.new(SUDOKU44).solve    #=> "1234431221433421"

If you see the same results in methods "solution " and "solve", then sudoku has got only one result

Check whether your array has got that same values in rows, columns or sub blocks. When your array is correct you should expect result nil.
In other situation you should received array of position with that same value.

    NSudoku::Checker.new(SUDOKU).repeat_in #=> nil
