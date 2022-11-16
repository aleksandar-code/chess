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
      update_graph
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

  def update_graph
    @graph = Graph.new
    @board.each { |x| x.each { |y| @graph.add_node(y) } }
  end

  def piece_placements
    array = %w[a1 b1 c1 d1 e1 f1 g1 h1 a2 b2 c2 d2 e2 f2 g2 h2 a8 b8 c8 d8 e8 f8 g8 h8 a7 b7 c7 d7 e7 f7 g7 h7]
  end

  def add_pieces_to_board
    @board[0..1] = add_per_row(@board[0..1], 1) # Black pieces
    @board[6..7] = add_per_row(@board[6..7], 0) # White pieces
    @board
  end

  def add_per_row(array, i)
    array_color = [@pieces.white_pieces, @pieces.black_pieces]
    index = 0

    array.each do |row|
      row.each do |square|
        piece = array_color[i][index]
        next unless piece.start_black.any?(square.coords) || piece.start_white.any?(square.coords)

        square.piece_move(piece, square.coords)
        index += 1
      end
    end
  end

  def create_board
    board = build_board
    update_graph
    add_pieces_to_board
  end

  def build_board
    black = "\e[1;40m   \e[0m"
    white = "\e[1;47m   \e[0m"
    @board = Array.new(8) { Array.new(8) }
    
    8.times do |rank|
      [white, black].rotate(rank % 2).cycle(4).with_index do |color, file|
        coords = [rank, file]
        @board[rank][file] = Node.new(coords, color)
      end
    end
  end
end
