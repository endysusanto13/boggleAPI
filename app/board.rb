class Boggle
  attr_reader :board, :row, :col, :total_letters, :letter_position_hash
  
  def initialize(unprocessed_string)
    @row, @col = 4, 4                                                                     # Number of rows and column of the board
    @total_letters = @row * @col
    
    letter_string = remove_characters_from_string(unprocessed_string)
    puts "Invalid input to the board" unless generate_board(letter_string)
  end
  
  def remove_characters_from_string(string_with_characters)
    string_with_characters.tr(",", "").tr(" ", "").tr("\n", "").upcase
    # Single quote ("") cannot be used to remove \n from .txt file
  end
  
  # Perform check whether use random board or default board or user's input
  def generate_board(letter_string)
    
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
    alphabets = ('A'..'Z').map(&:to_s) << "*"                                       # Convert ranges to string then add *
    (0...@total_letters).map { alphabets[rand(alphabets.length)] }.join
  end

  def default_board_string()
    default_board_txt = IO.readlines("../config/default_board.txt")[0]               # Load default board game
    remove_characters_from_string(default_board_txt)
  end
  
  def print_board()
    (0...@total_letters).each do |value|
      puts "\n" if value % @col == 0
      print "#{@board[value]} "
    end
    puts "\n\n"
  end

  def store_board_to_hash_table()
    # Create hash table with A-Z and *
    array = ("A".."Z").to_a << "*"
    @letter_position_hash = array.to_h {|letter| [letter, []]}

    # Store the position of letters on the board to the hash
    (0...@total_letters).each do |value|
      @letter_position_hash[@board[value]].append(value)
    end

  end

end

# Test

# board_1 = Boggle.new("A B C,,, D, E F G H, I J K ,,L, s O Pq")
# board_1.print_board()

# board_3 = Boggle.new("")
# board_3.print_board()

# board_4 = Boggle.new("RANDOM")
# board_4.print_board()

board_5 = Boggle.new("A C E D L U G * E * H T G A F K")
board_5.print_board()
board_5.store_board_to_hash_table()
puts board_5.letter_position_hash

