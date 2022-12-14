# frozen_string_literal: true

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
    @pawn_moves = []
  end
  attr_accessor :moves, :back_up, :board, :graph, :pawn_moves

  def print_board(id)
    print_notation()
    puts "\n\n                                                       A  B  C  D  E  F  G  H "
    first_board(8)
    puts "                                                       A  B  C  D  E  F  G  H \n\n\n\n\n"
    add_board_and_moves_and_graph()
  end

  def get_position
    str = ""
    @graph.nodes.each do |node|
      data = node.piece.can_castle if node.piece.instance_of? King
      pawns = node.piece.en_passant if node.piece.instance_of? Pawn
      str += node.coords.to_s + node.print_with_piece.to_s + data.to_s + pawns.to_s
    end
    str
  end

  def stalemate?(id)
    return false if @moves.length < 4
    king = nil
    @board.each do |x|
      x.each do |node|
        if node.piece.instance_of? King
          if node.piece.id == id
            king = node.piece
          end
        end
      end
    end
    back = Marshal.load( Marshal.dump(@board) )
    value = king.stalemate(id) unless king.nil?
    @board = Marshal.load( Marshal.dump(back) )
    value
  end

  def check_mate?(id)
    return false if @moves.length < 4
    king = nil
    @board.each do |x|
      x.each do |node|
        if node.piece.instance_of? King
          if node.piece.id == id
            king = node.piece
          end
        end
      end
    end
    back = Marshal.load( Marshal.dump(@board) )
    value = king.check_mate(id) unless king.nil?
    @board = Marshal.load( Marshal.dump(back) )
    value
  end

  def add_board_and_moves_and_graph
    @board.map { |x| x.each { |n| n.piece.nil? ? nil : n.piece.board=(@board) } }
    @board.map { |x| x.each { |n| n.piece.nil? ? nil : n.piece.moves=(@moves) } }
    unless @board.nil?
      update_graph
      @board.map { |x| x.each { |n| n.piece.nil? ? nil : n.piece.graph=(@graph) if n.piece.instance_of? King} }
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
    
    if check_mate?(player)
      print_board(player)
      return "checkmate"
    end

    if stalemate?(player)
      print_board(player)
      return "stalemate"
    end
    

    destination = nil
    start = nil
    boolean = nil
    string = nil
    capture = false
    loop do
      string = get_move()
      return string if string == "save" || string == "quit"
      start = get_square(string[0..1])
      destination = get_square(string[2..])
      if !(destination.piece.nil?)
        capture = true if destination.piece.id != player
      end
      boolean = start.piece.calc_move(start, destination, player)
      break if boolean == true || boolean == "promo" || boolean == "castling"
      
      puts "please enter a valid input"
    end

    boole = check_status(boolean, start, destination, string, player)
    return false if boole == false

    start = get_square(string[0..1])
    destination = get_square(string[2..])

    str = string[0..1] + "x" + string[2..] if capture == true
    notation(str) if capture == true
    if boolean == true || boolean =="promo"
      notation(string) if str == nil
    end
    
    destination.piece_move(start.piece, destination.coords) unless boolean == "promo" || boolean == "castling" 
    if boolean == "promo"
      piece = @pieces.promotion(player)
      destination.piece_move(piece, destination.coords)
    end
    get_pawns(destination.to_s)
    start.piece_remove unless boolean == "castling"
  end

  def get_pawns(destination)
    destination += "P" if destination.instance_of? Pawn
    @pawn_moves << destination
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
      bool = check?(king, coords, player)
      if bool == "check"
        puts "you're in check"
        @board = Marshal.load( Marshal.dump(back) )
        return false
      end
    end
    @board = Marshal.load( Marshal.dump(back) )
    true
  end

  def check?(king, coords, player)
    king.look_for_checks(coords, player)
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
    return input if input == "save" || input == "quit"
    if input.length == 4
      return input if @graph.get_node(input[0..1]) && @graph.get_node(input[2..]) && input[0..1] != input[2..]
    end
    input = nil
  end

  def get_square(coords)
    @board.each { |a| a.each { |n| return n if coords == n.coords } }
  end

  def get_move
    loop do
      string = valid_input(gets.chomp)
      return string if string == "save" || string == "quit"
      @board.each do |x|
        x.each do |node|
          next if string.nil? || string[0..1].nil? || !(node.coords == string[0..1])

          bool = !(node.piece.nil?)
          return string if string && bool == true
        end
      end
      puts "select a piece and it's destination : e2e4"
    end
  end

  def update_graph
    @graph = Graph.new
    @board.each { |x| x.each { |y| @graph.add_node(y) } }
  end

  def add_pieces
    array_color = [@pieces.black_pieces, @pieces.white_pieces]
    array = [@board[0..1], @board[6..7]]
    index = 0

    array.each_with_index do |board, i|
      board.each do |row|
        row.each do |square|
          piece = array_color[i][index]
          next unless piece.start_black.any?(square.coords) || piece.start_white.any?(square.coords)
          
          square.piece_move(piece, square.coords)
          index += 1
          index = 0 if index > 15
        end
      end
    end
    @board
  end

  def create_board
    board = build_board
    update_graph
    add_pieces
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
