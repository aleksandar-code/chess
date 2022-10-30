# frozen_string_literal: true

require 'pry-byebug'

class Board
  def initialize
    @green = "\e[1;0m   \e[0m"
    @white = "\e[1;47m   \e[0m"
    @board = create_board
  end

  def print_board
    puts "   A  B  C  D  E  F  G  H "
    i = 8
    @board.each do |x|
      print "#{i} "
      x.each do |n|
        print n
      end
      puts " #{i}\n"
      i -= 1
    end
    puts "   A  B  C  D  E  F  G  H "
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