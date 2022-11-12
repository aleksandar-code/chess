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
    @move_pattern = [[-1, -2, -1, -1], [0, 0, -1, 1]]
  end
  attr_accessor :piece, :start_white, :start_black, :current_position, :board, :en_passant, :id, :moves

  #write rules for pawn
  def get_pattern
    black = @move_pattern.map do |x|
      x.map do |n|
        n = n.reverse_aritmethic_symbol
      end
    end

    @id.zero? ? @move_pattern : black
  end

  def can_2_square(dest)
 
    if @id.zero?
      return true if @start_white.include?(@current_position) && can_move(dest)
        
    else
      return true if @start_black.include?(@current_position) && can_move(dest)
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

  def get_array_color
    if @id.zero?
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
    return false if @id != p_id
    strt = find_piece(start)
    dest = find_piece(destination)

    d = dest.dup
    d[0] = d[0] + 1 if id.zero?
    d[0] = d[0] - 1 if id == 1

    d = coords_to_node(d)

    valid_moves = possible_moves(strt, dest) if can_move(destination)
   
    return true if valid_moves.include?(dest)
    false
  end

  def can_attack(destination)
    if !(destination.piece.nil?) 
      if destination.piece.id != @id
        return true
      end
    end
  end

  def can_en_passant(destination)

  end

  def possible_moves(strt, dest)
    coords = strt.dup
    valid_moves = []
    pattern = get_pattern
    pattern_row = pattern[0]
    pattern_col = pattern[1]
    i = 0
    arr = get_array_color
    node = coords_to_node(strt)

    pattern_row.delete_at(1) unless arr.include?(node.coords)
    pattern_col.delete_at(1) unless arr.include?(node.coords)

    pattern_row.length.times do
      move = validate_move(coords.dup, [pattern_row[i], pattern_col[i]])
      valid_moves << move if move
      i += 1
    end
    return valid_moves
  end


  def validate_move(coords, pattern)
    coords[0] += pattern[0]
    coords[1] += pattern[1]
    return nil unless verify_coords(coords)
    node = coords_to_node(coords)
    return nil unless verify_node(node)
    coords
  end

  def verify_node(node)
    return true if node.piece.nil?

    return true if node.piece.id != @id

    false
  end

  def verify_coords(coords)
    return true if (0..7).include?(coords[0]) && (0..7).include?(coords[1])
    false
  end

  def coords_to_node(coords)
    @board.each_with_index do |x, a|
      x.each_with_index do |node, b|
        return node if [a, b] == coords
      end
    end
  end
end
