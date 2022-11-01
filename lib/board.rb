# frozen_string_literal: true

require 'pry-byebug'

require_relative './node'
require_relative './graph'
require_relative './pieces'

class Board
  def initialize
    @green = "\e[1;40m   \e[0m"
    @white = "\e[1;47m   \e[0m"
    @graph = Graph.new
    @pieces = Pieces.new
    @board = create_board
  end

  def print_board
    puts "\n\n\n\n                                                       A  B  C  D  E  F  G  H "
    i = 8
    @board.each do |array|
      print "                                                    #{i} "
      array.each do |node|
        if node.print_with_piece.nil?
          print node.square
        else
          print node.print_with_piece
        end
      end
      puts " #{i}\n"
      i -= 1
    end
    puts "                                                       A  B  C  D  E  F  G  H \n\n\n\n\n"
  end

  def add_nodes(board)
    board.each do |x|
      x.each do |y|
        @graph.add_node(y)
      end
    end
    # here add pieces to the node & code pieces classes
    add_piece_to_board(board)

  end

  def add_piece_to_board(board)
    rook = @pieces.pieces[0][0]

    board = board.each do |array|
      array.each do |node|
        if node.coords == "a1"
          node.piece=rook.piece
          square = node.square.dup
          node.piece_print(square)
        end
      end
    end
    board
  end

 

  def create_board
    board = board_colors
    add_nodes(board)
  end

  def board_colors
    final_array = []
    j = 0
    8.times do
      if j.odd?
        id = true
      else
        id = false
      end
      j += 1
      arr = Array.new(8)
      final_array << arr.each_with_index do |x, idx|
        data = [j-1, idx]
        if id == false && arr[idx].nil?
          arr[idx] = Node.new(data, @white)
          id = true
        elsif id == true && arr[idx].nil?
          arr[idx] = Node.new(data, @green)
          id = false
        end
      end
    end
    final_array
  end
end
