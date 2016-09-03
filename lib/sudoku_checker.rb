class SudokuChecker
  attr_reader :puzzle_array

  def initialize(puzzle_array)
    @puzzle_array = puzzle_array
  end

  def valid?
    valid_squares? && valid_rows? && valid_columns?
  end

  def complete?
    rows.each do |row|
      return false if row.include? 0
    end
    true
  end

  private

  def rows
    puzzle_array
  end

  def columns
    (0..8).map do |col_index|
      rows.map do |row|
        row[col_index]
      end
    end
  end

  def squares
    rows.each_slice(3).flat_map do |rows_block|
      result = rows_block.map do |row|
        row.each_slice(3).to_a
      end
      (0..2).map do |block_index|
        result.flat_map do |row_slice|
          row_slice[block_index]
        end
      end
    end
  end

  def valid_rows?
    valid_arrays?(rows)
  end

  def valid_squares?
    valid_arrays?(squares)
  end

  def valid_columns?
    valid_arrays?(columns)
  end

  def valid_arrays?(arrays)
    arrays.none? do |array|
      repetition?(array)
    end
  end

  def repetition?(array)
    array = array.reject(&:zero?)
    array.uniq.length <  array.length
  end
end
