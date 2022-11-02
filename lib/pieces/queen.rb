# frozen_string_literal: true

class Queen
  def initialize(piece)
    @piece = piece
    @start_white = ['d1']
    @start_black = ['d8']
  end
  attr_accessor :piece, :start_white, :start_black
end
