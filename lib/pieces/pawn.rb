# frozen_string_literal: true

class Pawn
  def initialize
    @unicode = '♟︎'
    @start_white = ['a2', 'b2', 'c2', 'd2', 'e2', 'f2', 'g2', 'h2']
    @start_black = ["a7", "b7", "c7", "d7", "e7", "f7", "g7", "h7"]
    @en_passant = nil
    @current_position = nil # Will use graph of nodes to see where this one can move
  end
  attr_accessor :current_position, :en_passant
end
