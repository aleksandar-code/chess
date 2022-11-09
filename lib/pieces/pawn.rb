# frozen_string_literal: true

require 'pry-byebug'

require_relative '../pieces/queen'

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
    @promo_white = ["a8", "b8", "c8", "d8", "e8", "f8", "g8", "h8"]
    @promo_black = ["a1", "b1", "c1", "d1", "e1", "f1", "g1", "h1"]
    @current_position = nil
    @id = id
    @board = nil
    @moves = nil
    @en_passant = nil # get the exact info of the pawn that can be taken and the pawn that can take it [can be taken, take it]
    @move_pattern = [[+1, +2, -1, -2], [0]]
  end
  attr_accessor :piece, :start_white, :start_black, :current_position, :board, :en_passant, :id, :moves

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
    return false if @moves.length < 3
    new_pat = pattern[0].reverse_aritmethic_symbol
    destination[0] = destination[0] + new_pat

    return false if !((0..7).include?(destination[0])) || !((0..7).include?(destination[1]))

    node = @board[destination[0]][destination[1]]
    return false  if node.piece.nil?
    start = @moves.last[0..1]
    dest = @moves.last[2..]
    id = node.piece.id
    arr = get_array_color(id)

    return node if node.piece.id != @id && arr.include?(start) && dest == node.coords
    false
  end

  def get_array_color(id)
    if id.zero?
      @start_white
    else
      @start_black
    end
  end

  def get_promo_arr
    if @id.zero?
      @promo_white
    else
      @promo_black
    end
  end

  def promotion(pawn_dest, node_dest)
    # the pawn reach the enemy camp backrow so he can be promoted to queen
    arr = get_promo_arr
    return "promo" if arr.include?(pawn_dest)
    
    false
  end

  def calc_move(start, destination, p_id)
    
    pattern = get_pattern
    return false if @id != p_id
    bool = promotion(destination.coords, destination)
    return "promo" if bool == "promo"
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

    move1 = move2 if move1.nil?
    move2 = move1 if move2.nil?
    if move1.piece.nil? && move2.piece.nil?
      moves = []
    else
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
