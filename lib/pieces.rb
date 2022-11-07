# frozen_string_literal: true

require 'pry-byebug'

require_relative './pieces/king'
require_relative './pieces/queen'
require_relative './pieces/rook'
require_relative './pieces/knight'
require_relative './pieces/bishop'
require_relative './pieces/pawn'

class Pieces
  def initialize()
    @white_pieces = []
    @black_pieces = []
    @pieces = %w[ ♜ ♞ ♝ ♛ ♚ ♝ ♞ ♜ ♟︎ ♟︎ ♟︎ ♟︎ ♟︎ ♟︎ ♟︎ ♟︎ ]
    create_pieces(white = "\e[1;34m ", 0)
    create_pieces(black = "\e[1;31m ", 1)
  end
  attr_accessor :white_pieces, :black_pieces, :board

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
      arr = build_pieces(array_pieces, id)
      arr.each do |x|
        array << x
      end
      array_pieces[8..].each do |piece|
        array << Pawn.new(piece, id)
      end
    else
      array_pieces[8..].each do |piece|
        array << Pawn.new(piece, id)
      end
      arr = build_pieces(array_pieces, id)
      arr.each do |x|
        array << x
      end
    end
    array
  end

  def build_pieces(array_pieces, id)
    array = []
    array << Rook.new(array_pieces[0], id)
    array << Knight.new(array_pieces[1], id)
    array << Bishop.new(array_pieces[2], id)
    array << Queen.new(array_pieces[3], id)
    array << King.new(array_pieces[4], id)
    array << Bishop.new(array_pieces[5], id)
    array << Knight.new(array_pieces[6], id)
    array << Rook.new(array_pieces[7], id)
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
