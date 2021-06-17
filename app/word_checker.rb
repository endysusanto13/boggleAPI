require_relative "dictionary.rb"
require_relative "board.rb"

class WordChecker
  def initialize(row, col)
    @row = row
    @col = col
    @total_letters = @row * @col
  end

  def verify_word_dictionary(word)
    ($dictionary.include? word) ? (puts "Word exist in English dictionary.") : (puts "Word does not exist in English dictionary.")
  end

  # Main function to verify whether a word can be formed on the board.
  # The function relies on hash table. The position on the board is stored on hash table which is passed to this function.
  def verify_word_on_board(word, letter_position_hash)
    word = word.upcase            # Since the letters on board is in capital letter
    
    i = 0
    while i >= 0 && i < word.length
      prev_search = @total_letters if i == 0
      puts "\nStart of while loop, prev_search is #{prev_search} and i is #{i}" ###
      move = false

      unless letter_position_hash[word[i]].empty?
        pos_arr = letter_position_hash[word[i]]
        print "Letter #{word[i]} exist at #{pos_arr}\n" ###

        pos_arr.each_with_index do | value , index |
          puts "Scanning through #{word[i]} at position #{value}" ###

          if value >= 0
            # The position is subtrated by no of total letters to indicate that it has been searched.
            # No of total letters is used so that duplicate of hash table is not required.
            letter_position_hash[word[i]][index] -= @total_letters            # Unable to use position variable here as it will not modify value in hash
            puts "#{value} has been subracted by @total_letters to #{letter_position_hash[word[i]][index]}"
            if prev_search == @total_letters || is_adjacent(letter_position_hash[word[i]][index],letter_position_hash[word[i-1]][prev_search])
              prev_search = index
              puts "Moving to next letter, prev_search now has been updated to #{prev_search}" ###
              i += 1
              move = true
              break
            end

          end
        end

        if move == false
          print "Hash undergoing restoration, current value is #{letter_position_hash[word[i]]}\n" ###
          letter_position_hash[word[i]].each_with_index do | value , index |
            letter_position_hash[word[i]][index] += @total_letters if value < 0
          end
          print "Hash completed restoration, current value is #{letter_position_hash[word[i]]}\n" ###


        end

      end
      
      # i -= 1 if move == false
      if move == false
        puts "Letter #{word[i]} is not available/not adjacent and i will be subtracted"
        i -= 1
      end
    end

    if i >= 0 
      puts "#{word} exists!"
      return true
    else
      puts "#{word} is not available."
      return false
    end
  end

  # Function that takes 2 integer numbers and verifies whether they are adjacent on the board
  def is_adjacent(letter_pos1, letter_pos2)
    puts "#{letter_pos1} is being subtracted by #{letter_pos2}..."
    case (letter_pos1 - letter_pos2).abs
    when 1
      return true
    when @col
      return true
    when @col + 1
      return true
    when @col - 1
      return true
    else
      return false
    end
  end

    


end

input = "gene"

# board_5 = Boggle.new("A C E D L U G * E * H T G A F K")
# board_5 = Boggle.new("A C E D L U G X E N H T G A F K")     # Without wildcard *
board_5 = Boggle.new("A C E D L U G X E N H T G N F K")     # Special case for GENE Without wildcard *
board_5.print_board()
board_5.store_board_to_hash_table()
# puts board_5.letter_position_hash
# puts board_5.board

checker4x4 = WordChecker.new(4,4)
checker4x4.verify_word_dictionary(input)
checker4x4.verify_word_on_board(input, board_5.letter_position_hash)







