# frozen_string_literal: true

class Rook
  def initialize(piece)
    @piece = piece
    @start_white = %w[a1 h1]
    @start_black = %w[a8 h8]
    # Will use graph of nodes to see where this one can move
  end
  attr_accessor :piece
end
