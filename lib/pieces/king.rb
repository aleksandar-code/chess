# frozen_string_literal: true

class King
  def initialize(piece, id)
    @piece = piece
    @start_white = ['e1']
    @start_black = ['e8']
    @check_status = nil
    @current_position = nil
    @board = nil
    @id = id
    @moves = moves
    @move_pattern = [[-1, -1, -1, 0, 0, +1, +1, +1], [0, +1, -1, +1, -1, -1, +1, 0]]
  end
  attr_accessor :piece, :start_white, :start_black, :current_position, :board, :moves
end
