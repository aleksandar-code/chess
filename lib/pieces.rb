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
    create_pieces(white = "\e[1;34m ", 0)
    create_pieces(black = "\e[1;31m ", 1)
  end
  attr_accessor :white_pieces, :black_pieces

  def add_piece(color, piece)
    @white_pieces << piece if color.zero?
    @black_pieces << piece unless color.zero?
  end

  def create_pieces(color, id)
    array = create_instances(give_color_piece(color), id)
    array.each do |piece|
      add_piece(id, piece)
    end
  end

  def create_instances(array_pieces, id)
    array = []
    if id > 0
      arr = build_pieces(array_pieces)
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
      arr = build_pieces(array_pieces)
      arr.each do |x|
        array << x
      end
    end
    array
  end

  def build_pieces(array_pieces)
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

  def give_color_piece(color)
    array = []
    i = 0
    @pieces.length.times do
      piece = @pieces[i]
      i += 1
      array << (set_color(color.dup, piece))
    end
    array
  end

  def set_color(color, piece)
    color[7] = piece
    color
  end

  def promotion; end
end
