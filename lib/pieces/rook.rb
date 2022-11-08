# frozen_string_literal: true

require 'pry-byebug'

class Rook
  def initialize(piece, id)
    @piece = piece
    @start_white = %w[a1 h1]
    @start_black = %w[a8 h8]
    @current_position = nil
    @board = nil
    @id = id
    @moves = nil
    # Will use graph of nodes to see where this one can move
    # this one can move in 4 directions calculate after every move
  end
  attr_accessor :piece, :start_white, :start_black, :current_position, :board, :moves, :id

  def can_move
    # check if a piece is in front "ally or enemy for pawn" if ally
  end

  def find_piece(search)
    @board.each_with_index do |row, i|
      row.each_with_index do |node, j|
        return [i, j] if node == search
      end
    end
  end

  def calc_move(start, destination, p_id)
    return false if @id != p_id
    strt = find_piece(start)
    dest = find_piece(destination)

    valid_moves = possible_moves(strt, dest)

    return true if valid_moves.include?(dest)
    false
  end

  def possible_moves(strt, dest)
    # up
    coords = strt.dup
    valid_moves = []
    pattern_up = [-1, 0]

    curr_moves = add_valid_moves(coords.dup, pattern_up)
    for move in curr_moves
      valid_moves << move
    end
    # down
    pattern_down = [1, 0]

    curr_moves = add_valid_moves(coords.dup, pattern_down)
    for move in curr_moves
      valid_moves << move
    end

    pattern_left = [0, -1]
    curr_moves = add_valid_moves(coords.dup, pattern_left)
    for move in curr_moves
      valid_moves << move
    end

    return valid_moves


    # create way for rook to go over the square
  end

  def validate_move(coords, pattern)
    coords[0] += pattern[0]
    coords[1] += pattern[1]
    return nil unless verify_coords(coords)
    node = coords_to_node(coords)
    return nil unless verify_node(node)
    coords
  end

  def add_valid_moves(coords, pattern)
    arr = []
    loop do
      coords = validate_move(coords, pattern)
      break if arr.include?(coords) || coords.nil?
      arr << coords.dup
    end
    arr
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
