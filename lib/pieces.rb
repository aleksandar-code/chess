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
    @pieces = %w[ ♜ ♞ ♝ ♛ ♚ ♝ ♞ ♜ ♟︎ ♟︎ ♟︎ ♟︎ ♟︎ ♟︎ ♟︎ ♟︎ ]
    create_white_pieces
    create_black_pieces
  end
  attr_accessor :white_pieces, :black_pieces

  def add_piece(color, piece)
    @white_pieces << piece if color.zero?
    @black_pieces << piece unless color.zero?
  end

  def create_instances(array_pieces, state)
    array = []
    if state > 0
      arr = create_pieces(array_pieces)
      arr.each do |x|
        array << x
      end
      array_pieces[8..].each do |piece|
        array << Pawn.new(piece)
      end
    else
      array_pieces[8..].each do |piece|
        array << Pawn.new(piece)
      end
      arr = create_pieces(array_pieces)
      arr.each do |x|
        array << x
      end
    end
  end

  def create_pieces(array_pieces)
    array = []
    array << Rook.new(array_pieces[0])
    array << Knight.new(array_pieces[1])
    array << Bishop.new(array_pieces[2])
    array << Queen.new(array_pieces[3])
    array << King.new(array_pieces[4])
    array << Bishop.new(array_pieces[5])
    array << Knight.new(array_pieces[6])
    array << Rook.new(array_pieces[7])
    array
  end

  def create_white_pieces
    black = "\e[1;31m "
    i = 0
    array = []
    @pieces.length.times do
      piece = @pieces[i]
      i += 1
      array << (set_color(black.dup, piece))
    end
    array = create_instances(array, 1)
    array.each do |piece|
      add_piece(1, piece)
    end
  end

  # how to create all of them? 
  def create_black_pieces
    white = "\e[1;34m "
    i = 0
    array = []
    @pieces.length.times do
      piece = @pieces[i]
      i += 1
      array << (set_color(white.dup, piece))
    end
    array = create_instances(array, 0)
    array.each do |piece|
      add_piece(0, piece)
    end
  end

  def set_color(color, piece)
    color[7] = piece
    color
  end

  def promotion; end
end

# May be i can add current_position for every piece here?
