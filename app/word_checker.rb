require_relative "dictionary.rb"
require_relative "board.rb"

class WordChecker
  def initialize(row, col)
    @row = row
    @col = col
    @total_letters = @row * @col

    @first_row = (0...@col).to_a
    @last_row = ((@total_letters-@col)...@total_letters).to_a
    
    @first_col = []
    (0...@total_letters).each { |num| @first_col << num if (num % @col == 0) }
    
    @last_col = []
    (0...@total_letters).each { |num| @last_col << num if ((num + 1) % @col == 0) }

    @memory = Array.new(0)          # Store letters that has been searched
  end
  
  def store_searched_letters(word_index, letter_position)
    if @memory[word_index].nil?
      inner_memory = Array.new(0)               
      inner_memory << letter_position
      @memory << inner_memory                   # Create nested array. Inner array is to store position of letter that has been searched.
    else
      @memory[word_index] << letter_position
    end
    
    print "Current memory is #{@memory}\n\n"
    # Remember to empty the hash at the end of search with hash.clear
  end

  def verify_word(word, board)
    @board = board

    ($dictionary.include? word) ? word_index = 0 : word_index = -1            # Words in dictionary are lower case
    word = word.upcase
    nested_array_letters = Array.new(0)
    nested_array_letters << (0...@total_letters).to_a    
    
    until word_index < 0 do
      puts "Word index is #{word_index}\n\n"
      
      letter_position = check_current_letter(word[word_index], nested_array_letters[word_index], word_index)
      puts "letter position is #{letter_position}"

      if letter_position
        store_searched_letters(word_index, letter_position)
        word_index += 1
        nested_array_letters[word_index] = check_adjacent_letters(letter_position)
        print "Nested array at word index #{word_index} is #{nested_array_letters[word_index]}\n\n"

      else
        @memory[word_index] = []
        word_index -= 1
        print "Memory is #{@memory}\n\n"
        print "Nested array at word index #{word_index} is #{nested_array_letters[word_index]}\n\n"
      end    
      
      if word_index > (word.length - 1)
        puts "#{word} exist!"
        break
      end
      
    end
    @memory = []          # Reset memory for other searches
  end
  
  def check_current_letter(letter, array_letters, word_index)
    puts "Searching for #{letter}..."
    position = false
   
    array_letters.each do |index|
      puts "Checking index #{index}..."
      puts "Position is #{position}"
      return position if position
        if @board[index].include? letter
          position = index
          
          if @memory[word_index]  #FIXME
            if @memory[word_index].include? index
              position = false
            end
          end
        else
          position = false
        end
    end
    
    puts "Found #{letter} at position #{position}"
  
  end

  def check_adjacent_letters(letter_index)
    adjacent_letter_positions = Array.new(0)

    # Store adjacent letters in an array        #FIXME
    adjacent_letter_positions << letter_index-(@col+1) unless (@first_row + @first_col).include? letter_index # top left letter
    adjacent_letter_positions << letter_index-@col     unless @first_row.include? letter_index                # up letter
    adjacent_letter_positions << letter_index-(@col-1) unless (@first_row + @last_col).include? letter_index  # top right letter
    adjacent_letter_positions << letter_index-1        unless @first_col.include? letter_index                # left letter
    adjacent_letter_positions << letter_index+1        unless @last_col.include? letter_index                 # right letter
    adjacent_letter_positions << letter_index+(@col-1) unless (@last_row + @first_col).include? letter_index  # bottom left letter
    adjacent_letter_positions << letter_index+@col     unless @last_row.include? letter_index                 # down letter
    adjacent_letter_positions << letter_index+(@col+1) unless (@last_row + @last_col).include? letter_index   # bottom right letter
    
    print "Adjacent letters are #{adjacent_letter_positions}\n\n"
    return adjacent_letter_positions
    # Change this to return position of adjacent letters
  end
end


input = "soaps"

board_2 = Boggle.new("T A P *  E A K S  O A R S  S * O D")
board_2.print_board()
board2 = board_2.get_board()

checker4x4 = WordChecker.new(4,4)
checker3x5 = WordChecker.new(3,5)

puts "\n"

checker4x4.verify_word(input, board2)