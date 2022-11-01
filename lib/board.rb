# frozen_string_literal: true

require 'pry-byebug'

require_relative './pieces/king'
require_relative './pieces/queen'
require_relative './pieces/rook'
require_relative './pieces/knight'
require_relative './pieces/bishop'
require_relative './pieces/pawn'
require_relative './node'
require_relative './graph'

class Board
  def initialize
    @green = "\e[1;40m   \e[0m"
    @white = "\e[1;47m   \e[0m"
    @graph = Graph.new
    @board = create_board
  end


  def create_black_pieces
    black = "\e[1;31m#{piece}\e[0m\e"
  end

  def create_white_pieces
    white = "\e[1;34m#{piece}\e[0m\e" # and then print them into the board before the game start
  end

  def print_board
    puts "\n\n\n\n                                                       A  B  C  D  E  F  G  H "
    i = 8
    @board.each do |array|
      print "                                                    #{i} "
      array.each do |node|
        print node.square
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
    add_pieces()
    p @graph.get_node("a8")
  end

  def add_pieces
    create_white_pieces()
    create_black_pieces()
  end

  def create_board
    board = board_colors
    add_nodes(board)
    board
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
