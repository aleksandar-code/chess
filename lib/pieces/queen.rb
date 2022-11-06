# frozen_string_literal: true

class Queen
  def initialize(piece, id)
    @piece = piece
    @start_white = ['d1']
    @start_black = ['d8']
    @current_position = nil
    @board = nil
    @id = id
    @moves = nil
    @move_pattern = [[+1, 0, -1, 0, -1, +1, -1, +1], [0, +1, 0, -1, -1, -1, +1, +1]]
  end
  attr_accessor :piece, :start_white, :start_black, :current_position, :board, :moves, :id
end
