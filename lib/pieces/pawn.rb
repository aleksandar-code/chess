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
    @en_passant = nil # get the exact info of the pawn that can be taken and the pawn that can take it [can be taken, take it]
    @move_pattern = [[+1, +2, -1, -2], [0]]
  end
  attr_accessor :piece, :start_white, :start_black, :current_position, :board, :en_passant

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

  def can_move(destination)
    return true if destination.piece.nil?
    false
  end

  def find_piece(search)
    @board.each_with_index do |row, i|
      row.each_with_index do |node, j|
        return [i, j] if node == search
      end
    end
  end

  def en_passant
    # same row as an enemy pawn and enemy pawn advanced by 2 square in one turn
    

  end

  def promotion
    # the pawn reach the enemy camp backrow so he can be promoted to queen
  end

  def calc_move(start, destination)
    
    pattern = get_pattern
    start = find_piece(start)
    dest = find_piece(destination)

    # moves = en_passant(destination)
    moves = attacks(start, pattern[0])
    binding.pry

    if @board[moves[0][0]][moves[0][1]].piece.nil? && @board[moves[1][0]][moves[1][1]].piece.nil?
      moves = []
    else
      if @board[moves[0][0]][moves[0][1]].piece.nil?
        moves.shift
      elsif @board[moves[1][0]][moves[1][1]].piece.nil?
        moves.pop
      end
    end

    moves << possible_moves(start[0], pattern[0], start.dup) if can_move(destination)
    moves << possible_moves(start[0], pattern[1], start.dup) if can_2_square && can_move(destination)
    return true if moves.include?(dest)
    false
  end

  def possible_moves(idx, pattern, start)
    start[0] = idx + pattern
    start
  end

  def attacks(start, pattern)
    x = start[0] + pattern
    y = start[1] + 1
    z = start[1] + -1

    [[x, y], [x, z]]
  end
end
