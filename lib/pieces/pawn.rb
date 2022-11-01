# frozen_string_literal: true

class Pawn
  def initialize
    @unicode = '♟︎'
    @start_white = ['a2', 'b2', 'c2', 'd2', 'e2', 'f2', 'g2', 'h2']
    @start_black = ["a8", "b8", "c8", "d8", "e8", "f8", "g8", "h8"]
    @en_passant = nil
    @current_position = nil # Will use graph of nodes to see where this one can move
  end
  attr_accessor :current_position, :en_passant
end
