# frozen_string_literal: true

class Knight
  def initialize(color)
    @unicode = '♞'
    @start_white = %w[b1 g1]
    @start_black = %w[b8 g8]
    @color = color
  end
  attr_accessor :piece, :start_white, :start_black
end
