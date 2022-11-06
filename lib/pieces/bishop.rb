# frozen_string_literal: true

class Bishop
  def initialize(piece, id)
    @piece = piece
    @start_white = %w[c1 f1]
    @start_black = %w[c8 f8]
    @current_position = nil
    @board = nil
    @id = id
    @moves = nil
    @move_pattern = [[-1, +1, -1, +1], [-1, -1, +1, +1]]
  end
  attr_accessor :piece, :start_white, :start_black, :current_position, :board, :moves, :id
end
