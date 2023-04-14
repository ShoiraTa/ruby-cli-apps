# frozen_string_literal: true

# Board class responsible for generationg board based on difficulty level
class Board
  def initialize(mode)
    @filled_cells = 0
    @board = Array.new(9) { Array.new(9, 0) }
    @mode = mode
  end

  attr_accessor :board, :filled_cells, :mode, :current_num

  def generate_board
    set_mode
    generate
    erase_cells
    print_board
  end

  def set_mode
    case mode
    when 'A'
      @filled_cells =  31
    when 'B'
      @filled_cells =  36
    when 'C'
      @filled_cells =  41
    else
      puts 'Please start again and slect correct difficulty mode.'
    end
  end

  def generate(row = 0, col = 0) # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
    return true if row == 9

    next_row, next_col = col == 8 ? [row + 1, 0] : [row, col + 1]

    return generate(next_row, next_col) if @board[row][col] != 0

    (1..9).to_a.shuffle.each do |num|
      if valid?(row, col, num)
        @board[row][col] = num
        return true if generate(next_row, next_col)
      end
    end
    @board[row][col] = 0
    false
  end

  def erase_cells
    arr = (0..8).to_a
    filled_cells.times do
      # binding.pry

      @board[arr.sample][arr.sample] = 0
    end
  end

  def valid?(row, col, num)
    !board[row].include?(num) && !board.transpose[col].include?(num) && !used_in_box?(row, col, num)
  end

  def used_in_box?(row, col, num)
    box_row = (row / 3) * 3
    box_col = (col / 3) * 3
    3.times do |i|
      3.times do |j|
        return true if board[box_row + i][box_col + j] == num
      end
    end
    false
  end

  def print_board
    puts '   1 2 3   4 5 6   7 8 9 '
    puts ' +-------+-------+-------+'
    print_rows
  end

  def print_rows
    board.each_with_index do |row, i|
      row_str = row.map { |num| num.zero? ? ' ' : num.to_s }.join(' ')
      puts "#{('A'.ord + i).chr}| #{row_str[0..4]} | #{row_str[6..10]} | #{row_str[12..16]} |"
      puts ' +-------+-------+-------+' if [2, 5].include?(i)
    end
  end
end
