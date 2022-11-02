# frozen_string_literal: true

require_relative './pieces/king'
require_relative './pieces/queen'
require_relative './pieces/rook'
require_relative './pieces/knight'
require_relative './pieces/bishop'
require_relative './pieces/pawn'

class Pieces
  def initialize
    @white_pieces = []
    @black_pieces = []
    create_white_pieces
    # create_black_pieces
  end
  attr_accessor :white_pieces, :black_pieces

  def add_piece(color, piece)
    @white_pieces << piece if color.zero?
    @black_pieces << piece unless color.zero?
  end

  def create_black_pieces
    # black = "\e[1;31m "
    # rook = Rook.new(black)
    # add_piece(1, rook)
  end

  def create_white_pieces
    # and then print them into the board before the game start
    white = "\e[1;34m "
    rook = Rook.new(set_color(white.dup, '♜'))
    add_piece(0, rook)
  end

  def set_color(color, piece)
    color[7] = piece
    color
  end

  def promotion; end
end

# May be i can add current_position for every piece here?
