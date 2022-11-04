# frozen_string_literal: true

class Queen
  def initialize(piece)
    @piece = piece
    @start_white = ['d1']
    @start_black = ['d8']
    @current_position = nil
  end
  attr_accessor :piece, :start_white, :start_black, :current_position
end
