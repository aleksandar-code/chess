# frozen_string_literal: true

require 'pry-byebug'

class Integer
  def reverse_aritmethic_symbol
    self.positive? ? -self : self.abs
  end
end

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
  attr_accessor :piece, :start_white, :start_black, :current_position, :board, :en_passant, :id

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

  def en_passant(destination, pattern)
    # same row as an enemy pawn and enemy pawn advanced by 2 square in one turn
    new_pat = pattern[0].reverse_aritmethic_symbol
    destination[0] = destination[0] + new_pat
    node = @board[destination[0]][destination[1]]
    return false  if node.piece.nil?
     
    return node if node.piece.id != @id
    false
  end

  def promotion
    # the pawn reach the enemy camp backrow so he can be promoted to queen
  end

  def calc_move(start, destination, p_id)
    
    pattern = get_pattern
    return false if @id != p_id
    start = find_piece(start)
    dest = find_piece(destination)

    to_capture = en_passant(dest.dup, pattern.dup)
    if to_capture != false
      to_capture.piece_remove
      return true
    end 

    moves = attacks(start, pattern[0])

    move1 = @board[moves[0][0]][moves[0][1]]
    move2 = @board[moves[1][0]][moves[1][1]]

    if move1.piece.nil? && move2.piece.nil?
      moves = []
    else
      binding.pry
      if move1.piece.nil? || move1.piece.id == @id
        moves.shift
      end
      if move2.piece.nil? || move2.piece.id == @id
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
