# frozen_string_literal: true

require_relative './board'
require_relative './graph'

class Node
  def initialize(coords, square, piece = nil)
    @coords = convert_data(coords)
    @square = square
    @piece = piece
    @print_with_piece = nil
  end
  attr_accessor :piece, :print_with_piece
  attr_reader :square, :coords

  def piece_print(sqr)
    return if piece.nil?
    
    sqr[8] = @piece.piece
    @print_with_piece = sqr
  end

  def piece_move(data, coord)
    @piece = data
    piece_print(@square.dup)
    @piece.current_position=(coord)
  end

  def piece_remove
    @piece = nil
    @print_with_piece = nil
  end

  def convert_data(data)
    %w[a b c d e f g h][data[1]] + %w[8 7 6 5 4 3 2 1][data[0]]
  end
end
