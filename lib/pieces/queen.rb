# frozen_string_literal: true

class Queen
  def initialize(color, current_position = nil)
    @unicode = '♛'
    @start_white = ['d1']
    @start_black = ['d8']
    @current_position = nil # Will use graph of nodes to see where this one can move
  end
  attr_accessor :current_position
end
