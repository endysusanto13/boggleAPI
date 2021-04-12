class Boggle
  def initialize(unprocessed_string)
    @row, @col = 4, 4                                                                     # Number of rows and column of the board
    @total_letters = @row * @col
    
    letter_string = check_board_type(unprocessed_string)
    letter_string.length == @total_letters ? (@board = generate_board(letter_string)) : (puts "Invalid number of letters.")
  end
  
  def remove_characters_from_string(string_with_characters)
    letter_string = string_with_characters.tr(",", "").tr(" ", "").tr("\n", "").upcase    # Convert default board string to an array. Single quote ("") cannot be used to remove \n from .txt file
  end
  
  def check_board_type(unprocessed_string)                                                # Check whether use random board or default board or user's input
    letter_string = remove_characters_from_string(unprocessed_string)
    
    case letter_string
    when "RANDOM" 
      return create_random_string()
    when ""
      return default_board_string()
    else
      return letter_string
    end
  end

  def create_random_string()
    alphabets = ('A'..'Z').map(&:to_s) << "*"
    random_string = (0...@total_letters).map { alphabets[rand(alphabets.length)] }.join
  end

  def default_board_string()
    default_board_txt = IO.readlines("../config/default_board.txt")[0]               # Load default board game
    remove_characters_from_string(default_board_txt)
  end

  def insert_letters_to_board(empty_board, letter_string)
    empty_board.map.with_index { |box, index| empty_board[index] = letter_string[index] }
  end
    
  def generate_board(letter_string)
    empty_board = Array.new(@total_letters)
    board_with_letters = insert_letters_to_board(empty_board, letter_string)
  end
  
  def print_board()
    (0...@row).each_with_index do |value, row_index|
      (0...@col).each_with_index { |value, col_index| print "#{@board[col_index + (row_index*@row)]} " }
      print "\n"
    end
  end

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

board_1 = Boggle.new("A B C,,, D, E F G H, I J K ,,L, s O Pq")
board_1.print_board()

board_3 = Boggle.new("")
board_3.print_board()

