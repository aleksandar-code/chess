# frozen_string_literal: true

class Knight
  def initialize(color)
    @unicode = '♞'
    @start_white = ['b1', 'g1']
    @start_black = ["b8", "g8"]
    @color = color
  end
  attr_accessor :color, :current_position
end
