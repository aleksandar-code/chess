# frozen_string_literal: true

require 'pry-byebug'

require_relative './node'
require_relative './graph'
require_relative './pieces'

class Board
  def initialize
    @graph = Graph.new
    @pieces = Pieces.new
    @board = create_board
    @moves = []
    @back_up = nil
  end
  attr_accessor :moves, :back_up

  def print_board(id)
    print_notation()
    puts "\n\n                                                       A  B  C  D  E  F  G  H "
    first_board(8)
    puts "                                                       A  B  C  D  E  F  G  H \n\n\n\n\n"
    add_board_and_moves_and_graph()
    
  end

  def check_mate?(id)
    return false if @moves.length < 4
    king = nil
    coords = nil
    id = 1 if id.zero?
    id = 0 if id == 1
    @board.each do |x|
      x.each do |node|
        if node.piece.instance_of? King
          if node.piece.id == id
            coords = node
            king = node.piece
          end
        end
      end
    end
    
    king.check_mate(coords, id) unless king.nil?
  end

  def add_board_and_moves_and_graph
    @board.map { |x| x.each { |n| n.piece.nil? ? nil : n.piece.board=(@board) } }
    @board.map { |x| x.each { |n| n.piece.nil? ? nil : n.piece.moves=(@moves) } }
    if !(@board.nil?)
      update_graph(@board)
      @board.map do |x|
        x.each do|n|
          if !(n.piece.nil?)
            n.piece.graph=(@graph) if n.piece.instance_of? King 
          end
        end
      end
    end
  end

  def first_board(num)
    @board.each do |array|
      print "                                                    #{num} "
      array.each do |node|
        statement = node.print_with_piece.nil?
        print node.square if statement
        print node.print_with_piece unless statement
      end
      puts " #{num}\n"
      num -= 1
    end
  end

  def move(player)
    back = Marshal.load( Marshal.dump(@board) )
    if check_mate?(player)
      @board = Marshal.load( Marshal.dump(back) )
      print_board(player)
      return "checkmate"
    end
    @board = Marshal.load( Marshal.dump(back) )

    destination = nil
    start = nil
    boolean = nil
    string = nil
    loop do
      string = get_move()
      start = get_square(string[0..1])
      destination = get_square(string[2..])
      boolean = start.piece.calc_move(start, destination, player)
      break if boolean == true || boolean == "promo" || boolean == "castling" || boolean == "check"
      
      puts "please enter a valid input"
    end
    boole = check_status(boolean.dup, start.dup, destination.dup, string.dup, player)
    return false if boole == false

    notation(string) if boolean == true || boolean =="promo" 
    destination.piece_move(start.piece, destination.coords) unless boolean == "promo" || boolean == "castling" 
    if boolean == "promo"
      piece = @pieces.promotion(player)
      destination.piece_move(piece, destination.coords)
    end

    start.piece_remove unless boolean == "castling" 
  end

 

  def check_status(boolean, start, destination, string, player)
    back = Marshal.load( Marshal.dump(@board) )
    
    if boolean && !(start.piece.instance_of? King)
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

      destination.piece_move(start.piece, destination.coords) unless boolean == "promo" || boolean == "castling"
      start.piece_remove unless boolean == "castling"

      bool = king.look_for_checks(coords, player)
      if bool == "check"
        puts "you're in check"
        @board = Marshal.load( Marshal.dump(back) )
        return false
      end
     
      
    elsif start.piece.instance_of? King
      king = start.dup
      destination.piece_move(start.piece, destination.coords)
      start.piece_remove 

      boolean = king.piece.calc_move(start, destination, player)
      
      if boolean == "check"
        puts "you're in check"
        @board = Marshal.load( Marshal.dump(back) )
        return false
      end
     
    end
    true
  end

  def notation(move)
    @moves << move
  end

  def print_notation
    i = 1
    @moves.each_with_index do |move, idx|
      print "#{i}. #{move}  "
      if idx.odd?
        i += 1
        print "\n\n"
      end
    end
  end

  def valid_input(input)
    if input.length == 4
      return input if @graph.get_node(input[0..1]) && @graph.get_node(input[2..]) && input[0..1] != input[2..]
    end
    input = nil
  end

  def get_square(coords)
    @board.each do |arr|
      arr.each do |n|
        return n if coords == n.coords
      end
    end
  end

  def get_move
    loop do
      string = valid_input(gets.chomp)
      bool = nil
      puts "select a piece and it's destination : e2e4" unless string
      next unless string
      @board.each do |x|
        x.each do |node|
          if node.coords == string[0..1]
            bool = !(node.piece.nil?)
          end
        end
      end
      return string if string && bool == true
      puts "select a piece and it's destination : e2e4"
    end
  end

  def update_graph(board)
    @graph = Graph.new
    board.each do |x|
      x.each do |y|
        @graph.add_node(y)
      end
    end
  end

  def piece_placements
    array = %w[a1 b1 c1 d1 e1 f1 g1 h1 a2 b2 c2 d2 e2 f2 g2 h2 a8 b8 c8 d8 e8 f8 g8 h8 a7 b7 c7 d7 e7 f7 g7 h7]
  end

  def add_pieces_to_board(board)
    board[0..1] = add_per_row(board[0..1], 1)
    board[6..7] = add_per_row(board[6..7], 0)
    board
  end

  def add_per_row(array, i)
    array_white = @pieces.white_pieces
    array_black = @pieces.black_pieces
    row = 0
    idx = 0
    arr = []
    2.times do
      arr << array[row].each do |node|
        next unless piece_placements.any?(node.coords) && i == 1 || i == 0 # only run first 2 and last 2 rows
        piece = array_white[idx] if i == 0
        piece = array_black[idx] if i == 1
        idx += 1
        row = 1 if idx == 8
        next unless piece.start_black.any?(node.coords) || piece.start_white.any?(node.coords)

        node.piece_move(piece, node.coords)
      end
    end
    arr[0] + arr[1] unless arr.nil?
    return arr unless arr.nil?
    false
  end

  def create_board
    board = build_board
    update_graph(board)
    add_pieces_to_board(board)
  end

  def build_board
    black = "\e[1;40m   \e[0m"
    white = "\e[1;47m   \e[0m"
    final_array = []
    j = 0
    8.times do
      j += 1
      arr = Array.new(8)
      final_array << board_colors_nodes(arr, j, j.odd?, black, white)
    end
    final_array
  end

  def board_colors_nodes(arr, num, id, black, white)
    arr.each_with_index do |_x, idx|
      data = [num - 1, idx]
      if id == false && arr[idx].nil?
        arr[idx] = Node.new(data, black)
        id = true
      elsif id == true && arr[idx].nil?
        arr[idx] = Node.new(data, white)
        id = false
      end
    end
  end
end
