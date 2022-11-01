# frozen_string_literal: true

class Bishop
  def initialize(color)
    @unicode = '♝'
    @start_white = %w[c1 f1]
    @start_black = %w[c8 f8]
    @color = color
  end
  attr_accessor :color
end
