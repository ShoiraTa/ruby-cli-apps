require 'pry'
require_relative "board"
require_relative "ui"

class Sudoku

  def initialize
    @ui = Ui.new
  end

  attr_accessor :ui

  def start
    ui.print_modes
    mode = gets.chomp
    board = Board.new(mode)
    board.generate_board
  end

end

new_game = Sudoku.new
new_game.start
