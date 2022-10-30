# frozen_string_literal: true

class Node
  def initialize(data, piece = nil)
    @data = data
    @piece = piece
  end
  attr_accessor :data, :piece
end
