# frozen_string_literal: true


class Rook
  def initialize(piece, id)
    @piece = piece
    @start_white = %w[a1 h1]
    @start_black = %w[a8 h8]
    @current_position = nil
    @board = nil
    @id = id
    @moves = nil
    @move_pattern =  [[+1, 0, -1, 0], [0, +1, 0, -1]]
    # Will use graph of nodes to see where this one can move
    # this one can move in 4 directions calculate after every move
  end
  attr_accessor :piece, :start_white, :start_black, :current_position, :board, :moves, :id

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
    coords = strt.dup
    valid_moves = []
    pattern_row = @move_pattern[0]
    pattern_col = @move_pattern[1]
    i = 0
    pattern_row.length.times do
      curr_moves = add_valid_moves(coords.dup, [pattern_row[i], pattern_col[i]])
      for move in curr_moves
        valid_moves << move
      end
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

  def add_valid_moves(coords, pattern)
    arr = []
    node = nil
    loop do
      coords = validate_move(coords, pattern)
      node = coords_to_node(coords) unless coords.nil?
      if !(node.nil?)
        if !(node.piece.nil?)
          arr << coords.dup
          break if node.piece.id != @id
        end
      end
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
