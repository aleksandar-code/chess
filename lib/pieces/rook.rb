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
    valid_moves = []
    coords = strt.dup
    pattern_up = -1
    binding.pry
    loop do
      coords[0] += pattern_up
      break unless verify_coords(coords)
      node = coords_to_node(coords)
      break unless verify_node(node)
      valid_moves << coords.dup
    end
    return valid_moves


    # down

    # create way for rook to go over the square
  end

  def verify_node(node)
    # check if the node is empty or has a piece, if it has a piece then check if it is an enemy piece if not then stop
    # and do not put this coords or node in moves

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
