# frozen_string_literal: true

require_relative './board'
require_relative './player'

class Game
  def initialize
    @board = Board.new
    @players = [Player.new(player_name), Player.new(player_name)]
  end

  def play

  end

  def player_name
    puts "Enter your name to get the white pieces"
    gets.chomp
  end
end