# Boogle API

A simple Boogle game with API implementation that is build with Ruby and HTML language only without requiring the use of Rails. (Work in Progress)

## Background

Boggle is a word game that is played on a 4x4 board with 16 letter tiles.
The goal is to find as many words as possible given a time constraint.
For this exercise, we are making one modification.
Now it is possible for one or more of the letter tiles to be blank (denoted by `*`).
When a tile is blank, it can be treated as any other letter.
Note that in one game it does not have to be the same character for each word.
For example, if the tiles C, *, and T are adjacent. The words cot, cat,
and cut can all be used.  You will be given a text file containing all
valid English words (a dictionary). You will also be given an initial board
configuration as a text file with commas separating the letters.
Use this as a guide for how to set up the board.

For example, a file may contain:

```
A, C, E, D, L, U, G, *, E, *, H, T, G, A, F, K
```

This is equivalent to the board:

```
A C E D
L U G *
E * H T
G A F K
```

Some sample words from this board are ace, dug, eight, hole, huge, hug, tide.


## Installation

- Install ruby

- Install rack

```
gem install rack
```

## How to start

1. Move to the same directory of this README.md with terminal
2. Type 'rackup' in the terminal to start the server
3. Go to http://localhost:3000/ (You may change the port at the config.ru file. Default port is 3000)
(Unfortunately this application is still incomplete)

## Incomplete Features
- Some elements of the game are still incomplete
- Integration with database (CRUD)
- API implementation (JSON format)

## Future Improvement
- Exception handling
- Ensure that the board generated will have sufficient words to be played (e.g. higher probability for vowels)
- Frontend upgrade
- Improve Security

## Optimization
- Load dictionary into Hashes based on word length and starting letter
- Store all possible words for a board on an array when board is created

## Known Bug
- Word 'soaps' could not be checked properly