# frozen_string_literal: true

class Bishop
  def initialize(piece)
    @piece = piece
    @start_white = %w[c1 f1]
    @start_black = %w[c8 f8]
  end
  attr_accessor :piece, :start_white, :start_black
end
