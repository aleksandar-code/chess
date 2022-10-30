# frozen_string_literal: true

class Rook
  def initialize
    @unicode_white = '♖'
    @unicode_black = '♜'
    @start_white = ['a1', 'h1']
    @start_black = ['a8', 'h8']
    @current_position = nil # Will use graph of nodes to see where this one can move
  end
  attr_accessor :unicode_white, :unicode_black, :start_white, :start_black, :current_position
end
