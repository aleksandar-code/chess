# frozen_string_literal: true

class King
  def initialize(color)
    @unicode = '♚'
    @start_white = ['e1']
    @start_black = ['e8']
    @check_status = nil
    @color = color
  end
  attr_accessor :color, :check_status
end
