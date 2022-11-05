# frozen_string_literal: true

require 'pry-byebug'

class Rook
  def initialize(piece)
    @piece = piece
    @start_white = %w[a1 h1]
    @start_black = %w[a8 h8]
    @current_position = nil
    @board = nil
    @move_pattern = [[+1, 0, -1, 0], [0, +1, 0, -1]]
    # Will use graph of nodes to see where this one can move
    # this one can move in 4 directions calculate after every move
  end
  attr_accessor :piece, :start_white, :start_black, :current_position, :board

  # write rules for the rook.

  def get_pattern
    @move_pattern
  end

  

  def can_move
    # check if a piece is in front "ally or enemy for pawn" if ally
  end

  def find_piece(search)
    @board.each_with_index do |row, i|
      row.each_with_index do |node, j|
        return [i, j] if node == search
      end
    end
  end

  def calc_move(start, destination)
    row_col = get_pattern
    start = find_piece(start)
    destination = find_piece(destination)

    moves = []
    moves << possible_moves(start, row_col)
    i = 0
    moves.length.times do
      moves << possible_moves(moves[0][i], row_col)
      i += 1
    end

    binding.pry
    return true if moves.include?(destination)
    false
  end

  def possible_moves(start, pattern)
    arr = []
    i = 0
    p start
    4.times do
      x = start[0] + pattern[0][i]
      z = start[1] + pattern[1][i]
      arr << [x, z]
      p arr
      i += 1
    end
    arr
  end

end
