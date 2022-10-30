# frozen_string_literal: true

require 'pry-byebug'

class Board
  def initialize
    @green = "\e[1;42m   \e[0m"
    @white = "\e[1;47m   \e[0m"
    @board = create_board
  end

  def print_board
    @board.each { |x| x.each { |n|  print n} }
  end
end