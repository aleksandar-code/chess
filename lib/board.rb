# frozen_string_literal: true

require 'pry-byebug'

class Board
  def initialize
    @green = "\e[1;42m   \e[0m"
    @white = "\e[1;47m   \e[0m"
    @board = create_board
  end

  def print_board
    @board.each do |x|
      x.each do |n|
        print n
      end
      puts "\n"
    end
  end

  def create_board
    id = false
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