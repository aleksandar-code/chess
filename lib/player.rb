# frozen_string_literal: true

require 'pry-byebug'

class Player
  def initialize(color, name)
    @color = color
    @name = name
  end
  attr_accessor :name, :color
end
