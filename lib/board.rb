# frozen_string_literal: true

require 'pry-byebug'

require_relative './pieces/king'
require_relative './pieces/queen'
require_relative './pieces/rook'
require_relative './pieces/knight'
require_relative './pieces/bishop'
require_relative './pieces/pawn'

class Board
  def initialize
    @green = {a8: "\e[1;40m   \e[0m"}
    @white = {a8: "\e[1;47m   \e[0m"}
    @board = create_board
  end

  def print_board
    puts "\n\n\n\n                                                       A  B  C  D  E  F  G  H "
    i = 8

    z = "\e[1;34m♜\e[0m\e"
    b = "\e[1;31m♜\e[0m\e"
    @board[7][7] = {a8: "\e[1;47m #{z}[1;47m \e[0m"}
    @board[0][7] = {a8: "\e[1;40m #{b}[1;40m \e[0m"}
    @board.each do |x|
      print "                                                    #{i} "
      x.each do |z|
        z.each do |k, v|
          print v
        end
      end
      puts " #{i}\n"
      i -= 1
    end
    puts "                                                       A  B  C  D  E  F  G  H \n\n\n\n\n"
  end

  def create_board
    board = board_colors
    p board
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
        if id == false && arr[idx].nil?
          arr[idx] = @white 
          id = true
        elsif id == true && arr[idx].nil?
          arr[idx] = @green
          id = false
        end
      end
    end
    final_array
  end
end