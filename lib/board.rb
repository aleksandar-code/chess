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
    first_board(8) # if game hasn't started
    puts "                                                       A  B  C  D  E  F  G  H \n\n\n\n\n"
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

  def add_nodes(board)
    board.each do |x|
      x.each do |y|
        @graph.add_node(y)
      end
    end
    # here add pieces to the node & code pieces classes
    add_pieces_to_board(board)
  end

  def piece_placements
    array = [
      %w[a1 b1 c1 d1 e1 f1 g1 h1],
      %w[a2 b2 c2 d2 e2 f2 g2 h2],

      %w[a8 b8 c8 d8 e8 f8 g8 h8],
      %w[a7 b7 c7 d7 e7 f7 g7 h7]
    ]
  end

  def add_pieces_to_board(board)
    rook = @pieces.pieces[0][0] # add all pieces in one go

    board.each do |array|
      array.each do |node|
        next unless node.coords == 'a1'

        node.piece = rook.piece
        square = node.square.dup # figure out a way to print the pieces at the start of the game.
        node.piece_print(square)
      end
    end
  end

  def create_board
    board = board_colors
    add_nodes(board)
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
