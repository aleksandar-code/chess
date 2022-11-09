# frozen_string_literal: true

class King
  def initialize(piece, id)
    @piece = piece
    @start_white = ['e1']
    @start_black = ['e8']
    @check_status = false
    @current_position = nil
    @board = nil
    @id = id
    @moves = nil
    @move_pattern = [[-1, -1, -1, 0, 0, +1, +1, +1], [0, +1, -1, +1, -1, -1, +1, 0]]
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
    castling(coords, dest, valid_moves)
    # add castling
    # boolean = look_for_checks(pattern_row, pattern_col, coords.dup, valid_moves.dup)

    pattern_row.length.times do
      move = validate_move(coords.dup, [pattern_row[i], pattern_col[i]])
      valid_moves << move if move
      i += 1
    end

    return valid_moves
  end

  def castling(coords, dest, valid_moves)
    # space between rook and king must be empty
    # king and rook mustnt have moved during the game
    # the king goes 2 square on the right or the left side
    # if any of the 2 squares the king travels is attacked then castling cannot happen
    # castling cannot happen if the king is currently in check
    

  end

  # def look_for_checks(pattern_row, pattern_col, coords, valid_moves)
  #   # but this one has to look if enemy piece attack him
  #   # and then we should do methods to find what move if there is any, can counter this attack. if not then checkmate.
  #   # the move counter the attack can be either taking the piece, putting a piece between them
  #   # or moving the king. then check if player move counter it then play the move only if it counter it.
  #   pattern_row.length.times do
  #     curr_moves = add_valid_moves(coords.dup, [pattern_row[i], pattern_col[i]]) 
  #     for move in curr_moves
  #       valid_moves << move
  #     end
  #     i += 1
  #   end
  # end

  def add_valid_moves(coords, pattern)
    arr = []
    loop do
      coords = validate_move(coords, pattern)
      break if arr.include?(coords) || coords.nil?
      arr << coords.dup
    end
    arr
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
