# frozen_string_literal: true

require 'pry-byebug'

class Player
  def initialize(color, name)
    binding.pry
    @color = color
    @name = name
  end
end