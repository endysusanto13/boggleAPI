require_relative "dictionary.rb"
require_relative "board.rb"

class WordChecker
  def initialize(row, col)
    @row = row
    @col = col
    @total_letters = @row * @col

    @position_matrix = create_position_array()
  end

  def verify_word_dictionary(word)
    ($dictionary.include? word) ? (puts "Word exist in English dictionary.") : (puts "Word does not exist in English dictionary.")
  end

  # Main function to verify whether a word can be formed on the board.
  # The function takes in a word (w) to be searched and a hash table that stores the position on the board (hash_table).
  # This function relies on backtracking algorithm which only check each possible sequence once.
  def verify_word_on_board(w, hash_table)
    w = w.upcase            # Since the letters on board is in capital letter

    p hash_table
    i = 0
    searched_index = {}                                               # Hash table to keep track what has been searched
    (0...w.length).each { |i| searched_index.store(i, -1)}            # Initiate values to indicate that no letters have been searched

    while i >= 0 && i < w.length
      # puts "\nStart of while loop, i = #{i}, searching letter #{w[i]}..." ###
      move = false

      unless hash_table[w[i]].empty?
        # print "Letter #{w[i]} exist at #{hash_table[w[i]]}\n" ###
        hash_table[w[i]].each_with_index do | value , index |
          # puts "Scanning through #{w[i]} at position #{value}" ###
          
          # This unmark the position that was used previously during backtracking.
          if value + @total_letters < 0
            # puts "Position #{hash_table[w[i]][index]} of #{w[i]} is restored..." ###
            hash_table[w[i]][index] += (@total_letters * 2)
            # puts "Position of #{w[i]} is now #{hash_table[w[i]][index]}." ###
          end

          if index <= searched_index[i]            # This skips letters that are already searched
            # puts "#{w[i]} at #{hash_table[w[i]][index]} is already searched." ###
            next
          end

          if value >= 0
                     
            # The position is subtrated by no of total letters to indicate that it has been searched.
            # No of total letters is used so that duplicate of hash table is not required.
            
            if i == 0 || is_adjacent(hash_table[w[i]][index],(@total_letters + hash_table[w[i-1]][searched_index[i-1]]))
              hash_table[w[i]][index] -= @total_letters
              # puts "#{value} has been subracted by @total_letters to #{hash_table[w[i]][index]}" ###
              
              
              searched_index[i] = index
              # puts "Moving to next letter, searched_index[#{i}] now has been updated to #{searched_index[i]}" ###
              move = true
              i += 1
              break
            end

          end
        end

      end

      # i -= 1 if move == false
      if move == false
        if i > 0
          # puts "Previously used #{w[i-1]} position of #{hash_table[w[i-1]][searched_index[i-1]]} is being marked for restoration." ###
  
          hash_table[w[i-1]][searched_index[i-1]] -= @total_letters         # To mark position to be restored to original value as it will not be used anymore
          # puts "Current position of #{w[i-1]} is #{hash_table[w[i-1]][searched_index[i-1]]}." ###
          searched_index[i] = -1
        end


        # puts "Letter #{w[i]} is not available/not adjacent and i will be subtracted" ###
        i -= 1
      end

    end

    # Restore back all coordinates for next word


    restore_hash_table(hash_table)

    # Check whether word exists.
    if i >= 0 
      puts "#{w} exists!"
      return true
    else
      puts "#{w} is not available."
      return false
    end
  
  end
      
      
  # Create 2D array to store positions based on number of letters 
  def create_position_array()
    array_2D = []
    array_1D = []

    (0...@row).each_with_index do |value, row_index|
      (0...@col).each_with_index { |value, col_index| array_1D.append(value+(row_index*@col)) }
      array_2D.append(array_1D)
      array_1D = []
    end

    return array_2D
  end

  # Function to return coordinate X and Y based on a given position on board
  def locate_coordinate(position)
    x = -1
    y = -1
    
    @position_matrix.each_with_index do |array, index| 
      if array.include?(position)
        y = index 
        x = array.index(position)
      end
    end
    return x, y
  end

  # Function that takes 2 integer numbers and verifies whether they are adjacent on the board
  def is_adjacent(letter_pos1, letter_pos2)
    # puts "#{letter_pos1} is being checked with adjacency with #{letter_pos2}..." ###
    
    x1, y1 = locate_coordinate(letter_pos1)
    x2, y2 = locate_coordinate(letter_pos2)

    dist_x = (x2 - x1)**2
    dist_y = (y2 - y1)**2
    distance = Math.sqrt(dist_x + dist_y)
    adjacent = Math.sqrt(2)

    # puts "It's adjacent" if distance <= adjacent ###
    return distance <= adjacent

  end

  # Restore the value of hash table after it is used to search a word
  # After a word search, the positions of the letter can be <0 due to the search algorithm
  def restore_hash_table(hash)
    hash.each do |v, k|
      unless k.empty?
        k.each_with_index { |_, index| hash[v][index] += @total_letters while hash[v][index] < 0 }
      end
    end
  end
    
end


# board_5 = Boggle.new("A C E D L U G * E * H T G A F K")
# board_5 = Boggle.new("A C E D L U G X E N H T G A F K")     # Without wildcard *
board_5 = Boggle.new("A C E D L U G X E N H E G N N K")     # Special BOARD for word GENE Without wildcard *
board_5.print_board()
board_5.store_board_to_hash_table()
# puts board_5.letter_position_hash
# puts board_5.board

checker4x4 = WordChecker.new(4,4)


loop do
  input = gets.chomp


  checker4x4.verify_word_dictionary(input)
  checker4x4.verify_word_on_board(input, board_5.letter_position_hash)
end









