class Boggle
  def initialize(unprocessed_string)
    @row, @col = 4, 4                                                                     # Number of rows and column of the board
    @total_letters = @row * @col
    
    letter_string = remove_characters_from_string(unprocessed_string)
    generate_board(letter_string)
  end
  
  def remove_characters_from_string(string_with_characters)
    string_with_characters.tr(",", "").tr(" ", "").tr("\n", "").upcase    # Single quote ("") cannot be used to remove \n from .txt file
  end
  
  def generate_board(letter_string)                                                # Perform check whether use random board or default board or user's input
    
    case letter_string
    when "RANDOM" 
      @board = create_random_string()
    when ""
      @board = default_board_string()
    else
      letter_string.length == @total_letters ? (@board = letter_string) : (@board = false)
    end

  end

  def create_random_string()
    alphabets = ('A'..'Z').map(&:to_s) << "*"
    (0...@total_letters).map { alphabets[rand(alphabets.length)] }.join
  end

  def default_board_string()
    default_board_txt = IO.readlines("../config/default_board.txt")[0]               # Load default board game
    remove_characters_from_string(default_board_txt)
  end
  
  def print_board()
    (0...@row).each_with_index do |value, row_index|
      (0...@col).each_with_index { |value, col_index| print "#{@board[col_index + (row_index*@row)]} " }
      print "\n"
    end
  end

  # FIXME - Use attr_accessor
  def get_board()
    @board
  end

  def get_row()
    @row
  end

  def get_col()
    @col
  end

end

# Test

board_1 = Boggle.new("A B C,,, D, E F G H, I J K ,,L, s O Pq")
board_1.print_board()
puts "\n"

board_3 = Boggle.new("")
board_3.print_board()
puts "\n"

board_4 = Boggle.new("RANDOM")
board_4.print_board()
puts "\n"

