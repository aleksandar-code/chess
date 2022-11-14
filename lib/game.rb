# frozen_string_literal: true

require 'pry-byebug'

require_relative './board'
require_relative './player'
 
class Game
  def initialize
    @turn = 0
    @board = Board.new
    @players = [Player.new(0, player_name), Player.new(1, player_name)]
  end

  def play
    loop do
      boolean = nil
      @board.print_board(@turn)
      loop do
        puts "\e[1;31m#{@players[@turn].name}\e[0m" + "\e[1;33m your turn with #{player_color} pieces. \e[0m"
        boolean = @board.move(@turn)
        break if boolean != false
      end

      if boolean == "checkmate"
        return puts "checkmate #{@players[@turn].name} wins!"
      end
      switch_player()
    end
  end

  def player_name
    puts "Enter your name to get the #{player_color} pieces"
    switch_player
    gets.chomp
  end

  def player_color
    return 'white' if @turn.zero?

    'black'
  end

  def switch_player
    @turn = if @turn.zero?
              1
            else
              0
            end
  end
end
