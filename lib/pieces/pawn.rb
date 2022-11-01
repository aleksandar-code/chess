# frozen_string_literal: true

class Pawn
  def initialize(color)
    @unicode = '♟︎'
    @start_white = %w[a2 b2 c2 d2 e2 f2 g2 h2]
    @start_black = %w[a7 b7 c7 d7 e7 f7 g7 h7]
    @en_passant = nil
    @color = color
  end
  attr_accessor :color, :en_passant
end
