# frozen_string_literal: true

class Bishop
  def initialize
    @unicode = '♝'
    @start_white = ['c1', 'f1']
    @start_black = ["c8", "f8"]
    @current_position = nil # Will use graph of nodes to see where this one can move
  end
  attr_accessor :current_position
end
