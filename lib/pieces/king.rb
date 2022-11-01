# frozen_string_literal: true

class King
  def initialize
    @unicode = '♚'
    @start_white = ['e1']
    @start_black = ['e8']
    @check_status = nil
    @current_position = nil # Will use graph of nodes to see where this one can move
  end
  attr_accessor :current_position, :check_status
end
