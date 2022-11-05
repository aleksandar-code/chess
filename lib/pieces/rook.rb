# frozen_string_literal: true

class Rook
  def initialize(piece)
    @piece = piece
    @start_white = %w[a1 h1]
    @start_black = %w[a8 h8]
    @current_position = nil
    @move_pattern = [[+1, 0, -1, 0], [0, +1, 0, -1]]
    # Will use graph of nodes to see where this one can move
    # this one can move in 4 directions calculate after every move
  end
  attr_accessor :piece, :start_white, :start_black, :current_position

  # write rules for the rook.


end
