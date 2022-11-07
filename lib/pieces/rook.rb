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
    @move_pattern = [[+1, 0, -1, 0], [0, +1, 0, -1]]
    # Will use graph of nodes to see where this one can move
    # this one can move in 4 directions calculate after every move
  end
  attr_accessor :piece, :start_white, :start_black, :current_position, :board, :moves, :id

  def get_pattern
    @move_pattern
  end

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
    pattern = get_pattern
    return false if @id != p_id
    strt = find_piece(start)
    dest = find_piece(destination)

    possible_moves(strt, dest, pattern)

    return true if moves.include?(dest)
    false
  end

  def possible_moves(strt, dest, pattern)
    # up
    current_coords = strt
    node_start = find_node(current_coords)
    node_destination = find_node(dest)
    stop = false
    until stop
      
    end

    # create way for rook to go over the square
  end

  def is_valid?(node)

  end

  def find_node(coords)
    @board.each_with_index do |x, a|
      x.each_with_index do |node, b|
        return node if [a, b] == coords
      end
    end
  end

end
