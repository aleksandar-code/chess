# frozen_string_literal: true

class Rook
  def initialize(piece)
    @piece = piece
    @start_white = %w[a1 h1]
    @start_black = %w[a8 h8]
    @current_position = nil
    # Will use graph of nodes to see where this one can move
  end
  attr_accessor :piece, :start_white, :start_black, :current_position

  def get_position
    # get the current position where this piece is located on the board of nodes.
  end
end
