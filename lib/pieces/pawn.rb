# frozen_string_literal: true

class Pawn
  def initialize(piece, id)
    @piece = piece
    @start_white = %w[a2 b2 c2 d2 e2 f2 g2 h2]
    @start_black = %w[a7 b7 c7 d7 e7 f7 g7 h7]
    @current_position = nil
    @id = id
    @board = nil
    @move_pattern = [[+1, +2, -1, -2], [0]]
  end
  attr_accessor :piece, :start_white, :start_black, :current_position, :board

  #write rules for pawn
  def get_pattern
    @id.zero? ? @move_pattern[0][0..1] : @move_pattern[0][2..]
  end

  def can_2_square
    if @id.zero?
      return true if @start_white.include?(@current_position)
    else
      return true if @start_black.include?(@current_position)
    end
    false
  end

  def find_piece
    @board.each do |row|
      row.each do |node|
        return node if node == @current_position
      end
    end
  end

  def calc_move
    pattern = get_pattern
    pattern << 0
    can_2_square
    
  end
end
