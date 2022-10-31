# frozen_string_literal: true

class Node
  def initialize(data, piece = nil)
    @data = data
    @piece = piece
    @neighbors = []
    @visited = false
  end
  attr_accessor :data, :piece, :neighbors, :visited
end
