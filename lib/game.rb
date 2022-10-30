# frozen_string_literal: true

require 'pry-byebug'

require_relative './board'
require_relative './player'

class Game
  def initialize
    @turn = 0
    @board = Board.new
    @players = [Player.new(player_color, player_name), Player.new(player_color, player_name)]
  end

  def play
    loop do
      @board.print_board
      puts "\e[1;31m#{@players[@turn].name}\e[0m" + "\e[1;33m your turn with #{player_color} pieces. \e[0m"
      break
    end
  end

  def player_name
    puts "Enter your name to get the #{player_color} pieces"
    switch_player
    gets.chomp
  end

  def player_color
    return 'white' if @turn == 0
    'black'
  end

  def switch_player
    if @turn.zero?
      @turn = 1
    else
      @turn = 0
    end
  end
end