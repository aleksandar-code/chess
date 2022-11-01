# frozen_string_literal: true

class Knight
  def initialize(color, current_position = nil)
    @unicode = '♞'
    @start_white = ['b1', 'g1']
    @start_black = ["b8", "g8"]
    @current_position = nil # Will use graph of nodes to see where this one can move
  end
  attr_accessor :current_position
end
