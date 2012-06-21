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

    > require 'nsudoku'
    > EXAMPLE = [
    >   "012000000",
    >   "304052000",
    >   "605170000",
    >   "070208090",
    >   "920700084",
    >   "050906010",
    >   "000320908",
    >   "000580107",
    >   "000000240"].join

    > NSudoku.new(EXAMPLE).solve #=> "712460850394852671685170420070208596926715384050906712540320968269584137030690245"

