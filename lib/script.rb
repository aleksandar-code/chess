# frozen_string_literal: true

require 'pry-byebug'

require_relative './game'
require_relative './board'
require_relative './player'

chess = Game.new
chess.play
binding.pry