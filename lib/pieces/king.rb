# frozen_string_literal: true

class King
  def initialize(piece)
    @piece = piece
    @start_white = ['e1']
    @start_black = ['e8']
    @check_status = nil
  end
  attr_accessor :piece, :start_white, :start_black
end
