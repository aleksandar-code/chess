# frozen_string_literal: true

require 'pry-byebug'

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
    @id.zero? ? @move_pattern[0][2..] :  @move_pattern[0][0..1]
  end

  def can_2_square
    if @id.zero?
      return true if @start_white.include?(@current_position)
    else
      return true if @start_black.include?(@current_position)
    end
    false
  end

  def can_move
    # check if a piece is in front
  end

  def find_piece(search)
    @board.each_with_index do |row, i|
      row.each_with_index do |node, j|
        return [i, j] if node == search
      end
    end
  end

  def calc_move(start, destination)
    pattern = get_pattern
    start = find_piece(start)
    destination = find_piece(destination)

    moves = []
    moves << possible_moves(start[0], pattern[0], start.dup)
    moves << possible_moves(start[0], pattern[1], start.dup) if can_2_square
    binding.pry
    return true if moves.include?(destination)
    false
  end

  def possible_moves(idx, pattern, start)
    start[0] = idx + pattern
    start
  end
end
