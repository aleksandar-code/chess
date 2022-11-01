# frozen_string_literal: true

class Rook
  def initialize(color)
    @unicode = '♜'
    @start_white = ['a1', 'h1']
    @start_black = ['a8', 'h8']
    @color = color # Will use graph of nodes to see where this one can move
  end
  attr_accessor :color
end
