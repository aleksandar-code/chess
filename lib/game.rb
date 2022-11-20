# frozen_string_literal: true

require 'pry-byebug'
require 'yaml'

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
      save?
      @positions << @board.get_position if @positions.length == 0
      return puts "50 moves rule, draw" if fifty_moves_rule?
      return puts "threefold repetition, draw" if threefold_repetion?
      return puts "insufficient material, draw" if insufficient_mating_material?
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

  def serialize
    yaml = YAML::dump(self)

    Dir.mkdir('saved_games') unless Dir.exist?('saved_games')

    game_file = "saved_games/saved.yaml"

    File.open(game_file, "w") do |file|
        file.puts yaml
    end

  end

  def fifty_moves_rule?
    array = @board.moves
    i = 0
    array.reverse.each do |x|
      i += 1 unless x[2] == "x" 
      return unless x[2] == "x"
    end
    return false if i < 50
    j = 0 
    @board.pawn_moves.reverse.each do |x|
      j += 1 unless x.include?("P")
    end

    return true if j > 49 && i > 49
    false


  end

  def threefold_repetion?
    @positions << @board.get_position

    array = @positions.uniq
    return true if array.length + 6 == @positions.length
    false
  end

  def insufficient_mating_material?
    nodes = @board.graph.nodes

    array_white = []
    array_black = []

    pawns = false

    nodes.each do |node|
      next if node.piece.nil?
      
      pawns = node.instance_of? Pawn
      return if node.instance_of? Pawn
    end

    return false if pawns

    nodes.each do |node|
      next if node.piece.nil?
      
      array_white << node.piece if node.piece.id == 0
      array_black << node.piece if node.piece.id == 1
      
    end

    if array_white.length == 2 || array_black.length == 2
      if array_white.length == 2 && array_black.length == 2
        return true if array_white.any?(Knight) && array_black.any?(Knight)
        return true if array_white.any?(Bishop) && array_black.any?(Knight)
        return true if array_white.any?(Knight) && array_black.any?(Bishop)
        return true if array_white.any?(Bishop) && array_black.any?(Bishop)
      elsif array_white.length == 2 && array_black.length == 1
        return true if array_white.any?(Knight)
        return true if array_white.any?(Bishop)
      elsif array_white.length == 1 && array_black.length == 2
        return true if array_black.any?(Knight)
        return true if array_black.any?(Knight)
      end
    end

    if array_white.length == 1 && array_black.length == 1
      return true
    end
    
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
