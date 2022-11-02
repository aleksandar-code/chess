# frozen_string_literal: true

class Pawn
  def initialize(piece)
    @piece = piece
    @start_white = %w[a2 b2 c2 d2 e2 f2 g2 h2]
    @start_black = %w[a7 b7 c7 d7 e7 f7 g7 h7]
  end
  attr_accessor :piece, :start_white, :start_black
end
