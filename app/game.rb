default_board_string = File.read("../config/default_board.txt")                     # Load default board game
default_board = default_board_string.tr(',', '').tr(' ', '').tr("\n", '').chars     # Convert default board string to an array. 
                                                                                    # Double quote is needed to remove \n from .txt file
class Boogle
  def initialize(board = [])
    @board = board
  end
end

Boogle.new(default_board)
