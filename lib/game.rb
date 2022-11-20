# frozen_string_literal: true

require 'pry-byebug'

require_relative './board'
require_relative './player'
 
class Game
  def initialize
    @turn = 0
    @board = Board.new
    @players = [Player.new(0, player_name), Player.new(1, player_name)]
    @positions = []
  end
  attr_accessor :positions

  def play
    loop do
      alert = "\e[1;31m#{@players[@turn].name}\e[0m" + "\e[1;33m your turn with #{player_color} pieces. \e[0m"
      @board.print_board(@turn)
      @positions << @board.get_position if @positions.length == 0
      return puts "draw" if threefold_repetion?
      loop do
        puts alert
        boolean = @board.move(@turn)
        return puts "stalemate" if is_stalemate(boolean)
        return puts "checkmate #{@players[@turn].name} wins!" if is_game_over?(boolean)
        break if boolean != false
      end
      switch_player()
    end
  end

  def threefold_repetion?
    @positions << @board.get_position

    array = @positions.uniq
    return true if array.length + 6 == @positions.length
    false
  end

  def insufficient_mating_material?
    board = @board.graph

  end

  def is_game_over?(boolean)
    if boolean == "checkmate"
      true
    elsif boolean != false
      false
    end
  end

  def is_stalemate(boolean)
    if boolean == "stalemate"
      true
    elsif boolean != false
      false
    end
  end

  def player_name
    puts "Enter your name to get the #{player_color} pieces"
    switch_player
    gets.chomp
  end

  def player_color
    @turn.zero? ? 'white' : 'black'
  end

  def switch_player
    @turn = @turn.zero? ? 1 : 0 
  end
end
