class Board
  def initialize(mode)
    @filled_cells = 0
    @board =[]
    @mode = mode
  end

  attr_accessor :board, :filled_cells, :mode

  def generate_board_cells
    @board = 9.times.map{(1..9).to_a.shuffle}
    print_board
  end
  
  def generate_board  
    case mode
    when "A"
      filled_cells =  35
    when "B"
      filled_cells =  25
    when "C"
      filled_cells =  15
    else 
      puts "Please start again and slect correct difficulty mode."
    end
    generate_board_cells
  end
  def print_board
    
    puts "   1 2 3   4 5 6   7 8 9 "
    puts " +-------+-------+-------+"
    board.each_with_index do |row, i|     
      row_str = row.map{|num| num==0? " " : num.to_s}.join(" ")
      puts "#{('A'.ord + i).chr}| #{row_str[0..4]} | #{row_str[6..10]} | #{row_str[12..16]} |"
      puts " +-------+-------+-------+" if [2, 5].include?(i)
    end
  end
end