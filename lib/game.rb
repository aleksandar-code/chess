# frozen_string_literal: true

require_relative './board'
require_relative './player'

class Game
  def initialize
    @turn = 0
    @board = Board.new
    @players = [Player.new(player_color, player_name), Player.new(player_color, player_name)]
  end

  def play

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