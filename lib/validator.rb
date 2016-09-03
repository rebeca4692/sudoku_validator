class Validator
  require 'sudoku_checker'

  INVALID_SUDOKU = "This sudoku is invalid."
  VALID_INCOMPLETE = "This sudoku is valid, but incomplete."
  VALID_COMPLETE = "This sudoku is valid."

  def initialize(puzzle_string)
    @puzzle_string = puzzle_string
  end

  def self.validate(puzzle_string)
    new(puzzle_string).validate
  end

  def validate
    parsed_puzzle = parse
    @checked_sudoku = SudokuChecker.new(parsed_puzzle)
    output
  end

  def parse
    parsed_string = @puzzle_string.gsub(/\D/, "")
    parsed_string.chars.map(&:to_i).each_slice(9).to_a
  end

  def output
    return INVALID_SUDOKU unless @checked_sudoku.valid?
    return VALID_INCOMPLETE unless @checked_sudoku.complete?
    VALID_COMPLETE
  end
end
