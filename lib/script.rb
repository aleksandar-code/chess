# frozen_string_literal: true

require 'yaml'

require_relative './game'
require_relative './board'
require_relative './player'

print "Want to load a saved game? Enter 'replay': "
do_load = gets.chomp

$chess = Game.new unless do_load == "replay"

if Dir.exist?('saved_games') && do_load == "replay"
    game_file = File.new("saved_games/saved.yaml")
    yaml = game_file.read
    $chess = Psych.unsafe_load(yaml)
    puts "\n"
end
$chess.play
