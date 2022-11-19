# frozen_string_literal: true

require_relative './pawn'

class King
  def initialize(piece, id)
    @piece = piece
    @start_white = ['e1']
    @start_black = ['e8']
    @check_status = false
    @current_position = nil
    @board = nil
    @id = id
    @can_castle = nil
    @moves = nil
    @graph = nil
    @move_pattern = [[-1, -1, -1, 0, 0, +1, +1, +1], [0, +1, -1, +1, -1, -1, +1, 0]]
  end
  attr_accessor :piece, :start_white, :start_black, :current_position, :board, :moves, :id, :graph, :can_castle

  def can_castle?
    i = 0
    search = @moves.map do |x|
      x = x[0..1]
    end

    if search.include?(coords_to_node(@current_position).coords)
      @can_castle = false
    end

    if search.include?("h1")
      @can_castle = false
    else
      if search.include?("a1")
        @can_castle = false
      end
      @can_castle = true
    end
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
    valid_moves = []
    strt = find_piece(start)
    dest = find_piece(destination)
    bool = look_for_checks(destination, @id)
    return "check" if bool == "check"
    return "checkmate" if bool == true
    bool = castling(strt, dest, valid_moves)
    @can_castle = false if bool == true
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
    

    pattern_row.length.times do
      move = validate_move(coords.dup, [pattern_row[i], pattern_col[i]])
      valid_moves << move if move
      i += 1
    end

    return valid_moves
  end

  def castling(start, dest, valid_moves) # Refactor castling and test_moves

    if @id.zero?
      pat = 7
      number = 1
    else
      pat = 0
      number = 8
    end

    info_moves = ["e#{number}", "h#{number}", "a#{number}"]
    info_move = ["g#{number}", "c#{number}"]
    info_coords = [[pat, 7], [pat, 6], [pat, 5]], [[pat, 0], [pat, 2], [pat, 3]]
      return unless verify_piece_castling(start.dup, dest.dup)
      king = coords_to_node(start)
      idx = nil
      if coords_to_node(dest).coords == info_move[0]
        idx = 0
      elsif coords_to_node(dest).coords == info_move[1]
        idx = 1
      end
    unless idx.nil?
      info_coords = info_coords[idx]
      rook = coords_to_node(info_coords[0])
      next_king = coords_to_node(info_coords[1])
      next_rook = coords_to_node(info_coords[2])
      if next_king.piece.nil? && next_rook.piece.nil?
        bool1 = look_for_checks(next_king, @id)
        bool2 = look_for_checks(next_rook, @id)
        return false unless bool1 == false && bool2 == false
      else
        return false
      end
      next_king.piece_move(king.piece, next_king.coords)
      next_rook.piece_move(rook.piece, next_rook.coords)
      king.piece_remove
      rook.piece_remove
      return true
    end
  end

  def verify_piece_castling(start, dest)
    i = 0
    search = @moves.map do |x|
      x = x[0..1]
    end

    if search.include?(coords_to_node(start).coords)
      return false
    end
    dest[1] = 7 if dest[1] > 4
    dest[1] = 0 if dest[1] < 4
    if search.include?(coords_to_node(dest).coords)
      return false
    end
    true
  end

  def look_for_checks(dest_node, king_id)
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

  def check_mate(dest_node, our_id)
    all_moves = @graph.check_all_moves(our_id)
    array_checks = test_moves(all_moves, our_id)

    if array_checks.all?("check")
      return true
    end
    false
  end
  
  def test_moves(start_dest, player)
    array_checks = []
    start_dest.each do |pair|
      back = Marshal.load( Marshal.dump(@board) )
      start = coords_to_node(pair[0])
      destination = coords_to_node(pair[1])
      if !(start.piece.instance_of? King)
        coords = nil
        king = nil
        @board.each_with_index do |x, i|
          x.each_with_index do |node, j|
            if node.piece.instance_of? King 
              king = node.piece if node.piece.id == player
              coords = node if node.piece.id == player
            end
          end
        end
        destination.piece_move(start.piece, destination.coords) 
        start.piece_remove

        bool = king.look_for_checks(coords, player)
        if bool == "check"
          array_checks << "check"
          @board = Marshal.load( Marshal.dump(back) ) unless array_checks.any?(nil)
        else
          array_checks << pair
          @board = Marshal.load( Marshal.dump(back) ) unless array_checks.any?(nil)
        end
      elsif start.piece.instance_of? King
        king = start.dup
        destination.piece_move(start.piece, destination.coords)
        start.piece_remove 
  
        boolean = king.piece.calc_move(start, destination, player)
        
        if boolean == "check"
          array_checks << "check"
          @board = Marshal.load( Marshal.dump(back) ) unless array_checks.any?(nil)
        else
          array_checks << pair
          @board = Marshal.load( Marshal.dump(back) ) unless array_checks.any?(nil)
        end
      end
      
    end
    array_checks
  end

  def stalemate(coords, id)
      array = []
      all_moves = @graph.check_all_moves(id)
      array_checks = test_moves(all_moves, id)

      array_checks.each do |element|
        array << element unless element == "check"
      end
      return true if array.length == 0
      
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
