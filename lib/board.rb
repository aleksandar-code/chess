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
  end

  def print_board
    puts "\n\n\n\n                                                       A  B  C  D  E  F  G  H "
    first_board(8)
    puts "                                                       A  B  C  D  E  F  G  H \n\n\n\n\n"
    add_board_at_piece()
  end

  def add_board_at_piece
    @board.map { |x| x.each { |n| n.piece.nil? ? nil : n.piece.board=(@board) } }
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

  # may be later add a noteboard to see all the moves made and a fen converter and an ai and board flip for player
  def move(player)
    string = get_move()
    # next only if piece can move on square in board at piece
    start = get_square(string[0..1])
    destination = get_square(string[2..])
    start.piece.calc_move(start, destination)
    
    destination.piece_move(start.piece, destination.coords)
    start.piece_remove
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
      return string if string
      puts "enter the start and destination square 'e2e4'"
    end
  end

  def create_graph(board)
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
    board = board_colors
    create_graph(board)
    add_pieces_to_board(board)
  end

  def board_colors
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
