# frozen_string_literal: true

class Queen
  def initialize(color)
    @unicode = '♛'
    @start_white = ['d1']
    @start_black = ['d8']
    @color = color
  end
  attr_accessor :piece, :start_white, :start_black
end
