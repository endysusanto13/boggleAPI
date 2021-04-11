class Boggle
  def initialize(unprocessed_string)
    @row, @col = 4, 4                                                                     # Number of rows and column of the board
    @total_letters = @row * @col
    verify_number_of_letters(unprocessed_string) ? (@board = generate_board(unprocessed_string)) : (puts "Invalid number of letters.")
  end
  
  def remove_characters_from_string(string_with_characters)
    letter_string = string_with_characters.tr(",", "").tr(" ", "").tr("\n", "").upcase    # Convert default board string to an array. Single quote ("") cannot be used to remove \n from .txt file
  end
  
  def verify_number_of_letters(unprocessed_string)
    remove_characters_from_string(unprocessed_string).length == @total_letters ? true : false
  end

  def create_empty_board()
    empty_board = Array.new(@total_letters)
  end
  
  def insert_letters_to_board(empty_board, letter_string)
    empty_board.each_with_index { |value, index| empty_board[index] = letter_string[index]}
    return empty_board
  end
    
  def generate_board(unprocessed_string)
    empty_board = create_empty_board()
    letter_string = remove_characters_from_string(unprocessed_string)
    board_with_letters = insert_letters_to_board(empty_board, letter_string)
  end
  
  def print_board()
    (0...@row).each_with_index do |value, row_index|
      (0...@col).each_with_index { |value, col_index| print "#{@board[col_index + (row_index*@row)]} " }
      print "\n"
    end
  end

end

def read_default_board()
  default_board_txt = IO.readlines("../config/default_board.txt")[0]               # Load default board game
end

board_1 = Boggle.new("A B C D, E F G H, I J K ,,L, s O Pq")
board_1.print_board()

board_2 = Boggle.new(read_default_board())
board_2.print_board()




