# Sudoku

This gem solve puzzle game sudoku 9x9

## Installation

Add this line to your application's Gemfile:

    > gem 'nsudoku'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install nsudoku

## Usage

Usage class NSudoku for example:

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

Solve game the sudoku

    > require 'nsudoku'
    > NSudoku.new(EXAMPLE).solve #=> "712460850394852671685170420070208596926715384050906712540320968269584137030690245"

Check whether your array has got that same values in rows, columns or sub blocks. When your array is correct you should expect result nil.
In other situation you should received array of position with that same value.

    > NSudoku::Checker.new(EXAMPLE).repeat_in #=> nil

