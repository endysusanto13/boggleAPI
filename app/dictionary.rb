$dictionary = IO.readlines("../lib/dictionary.txt")     # Convert all words in .txt files to array
$dictionary.map! { |word| word.chomp }                  # Remove newline from all words