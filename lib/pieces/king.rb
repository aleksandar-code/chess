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
    valid_moves = []
    strt = find_piece(start)
    dest = find_piece(destination)
    bool = look_for_checks(destination, @id)
    return "check" if bool == "check"
    bool = castling(strt, dest, valid_moves)
    return "castling" if bool == true

    valid_moves = possible_moves(strt, dest)
    return false if valid_moves == true

    return true if valid_moves.include?(dest)
    false
  end

  def possible_moves(strt, dest)
    coords = strt.dup
    valid_moves = []
    pattern_row = @move_pattern[0]
    pattern_col = @move_pattern[1]
    i = 0
    # add castling
    # boolean = look_for_checks(pattern_row, pattern_col, coords.dup, valid_moves.dup)


    pattern_row.length.times do
      move = validate_move(coords.dup, [pattern_row[i], pattern_col[i]])
      valid_moves << move if move
      i += 1
    end

    return valid_moves
  end

  # next step is making checks

  def castling(start, dest, valid_moves)
    # space between rook and king must be empty /// done
    # king and rook mustnt have moved during the game /// done
    # the king goes 2 square on the right or the left side /// done
    # if any of the 2 squares the king travels is attacked then castling cannot happen
    # castling cannot happen if the king is currently in check
    if @id.zero? # for white
      arr = %w[e1 h1 a1]
      return unless verify_piece_castling(arr)
      king = coords_to_node(start)
      if dest == [7, 6] # 0-0
        rook = coords_to_node([7, 7])
        next_king = coords_to_node([7, 6])
        next_rook = coords_to_node([7, 5])
        return false unless next_king.piece.nil? && next_rook.piece.nil?
        next_king.piece_move(king.piece, next_king.coords)
        next_rook.piece_move(rook.piece, next_rook.coords)
        king.piece_remove
        rook.piece_remove
        return true

      elsif dest == [7, 2] # 0-0-0
        rook = coords_to_node([7, 0])
        next_king = coords_to_node([7, 2])
        next_rook = coords_to_node([7, 3])
        return false unless next_king.piece.nil? && next_rook.piece.nil?
        next_king.piece_move(king.piece, next_king.coords)
        next_rook.piece_move(rook.piece, next_rook.coords)
        king.piece_remove
        rook.piece_remove
        return true
      end
    else
      arr = %w[e8 h8 a8]
      return unless verify_piece_castling(arr)
      king = coords_to_node(start)
      if dest == [0, 6] # 0-0
        rook = coords_to_node([0, 7])
        next_king = coords_to_node([0, 6])
        next_rook = coords_to_node([0, 5])
        return false unless next_king.piece.nil? && next_rook.piece.nil?
        next_king.piece_move(king.piece, next_king.coords)
        next_rook.piece_move(rook.piece, next_rook.coords)
        king.piece_remove
        rook.piece_remove
        return true

      elsif dest == [0, 2] # 0-0-0
        rook = coords_to_node([0, 0])
        next_king = coords_to_node([0, 2])
        next_rook = coords_to_node([0, 3])
        return false unless next_king.piece.nil? && next_rook.piece.nil?
        next_king.piece_move(king.piece, next_king.coords)
        next_rook.piece_move(rook.piece, next_rook.coords)
        king.piece_remove
        rook.piece_remove
        return true
      end
    end

  end

  def verify_piece_castling(arr)
    i = 0
    search = @moves.map do |x|
      x = x[0..1]
    end

    arr.length.times do
      return false if search.include?(arr[i])
      i += 1
    end
    true
  end

  def look_for_checks(dest_node, king_id) 
    # instead make sure the player cannot
    # do a move that will result in his king being taken by any of the enemy pieces the move after
    # check if any enemy piece on the board can take the king
    
    @board.each do |x|
      x.each do |node|
        unless node.piece.nil?
          next if node.piece.instance_of? King
          if node.piece.id != king_id
            bool = node.piece.calc_move(node, dest_node, node.piece.id)
            if bool == true
              return "check"
            end
          end
        end
      end
    end
    false
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
