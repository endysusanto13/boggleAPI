dictionary = IO.readlines("../lib/dictionary.txt")
dictionary.map! { |word| word.chomp }