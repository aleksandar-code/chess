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

    possible_moves(strt, dest)

    return true if moves.include?(dest)
    false
  end

  def possible_moves(strt, dest)
    # up
    valid_moves = []
    current_coords = strt
    node_start = coords_to_node(current_coords)
    node_destination = coords_to_node(dest)
    stop = false
    until stop

    end


    # down

    # create way for rook to go over the square
  end

  def verify_node(node)

  end

  def verify_coords(coords)
    return true if (0..7).include?(coords[0]) && (0..7).include?(coords[1])
  end

  def coords_to_node(coords)
    @board.each_with_index do |x, a|
      x.each_with_index do |node, b|
        return node if [a, b] == coords
      end
    end
  end

end
