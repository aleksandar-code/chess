# frozen_string_literal: true

require_relative './pieces/king'
require_relative './pieces/queen'
require_relative './pieces/rook'
require_relative './pieces/knight'
require_relative './pieces/bishop'
require_relative './pieces/pawn'

class Pieces
  def initialize
    @pieces = [[],[]]
  end

  def add_piece(i, piece)
    @pieces[i] << piece
  end

  def create_black_pieces
    black = "\e[1;31m#{piece}"
  end

  def create_white_pieces
    white = "\e[1;34m#{piece}" # and then print them into the board before the game start
  end
  
  def promotion

  end
end

# May be i can add current_position for every piece here?