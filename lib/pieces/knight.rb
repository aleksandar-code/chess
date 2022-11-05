# frozen_string_literal: true

class Knight
  def initialize(piece)
    @piece = piece
    @start_white = %w[b1 g1]
    @start_black = %w[b8 g8]
    @current_position = nil
    @move_pattern =[[-2, -2, -1, -1, +2, +2, +1, +1], [-1, +1, -2, +2, -1, +1, -2, +2]]
  end
  attr_accessor :piece, :start_white, :start_black, :current_position
end
