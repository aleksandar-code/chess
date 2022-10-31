# frozen_string_literal: true

require_relative './board'
require_relative './graph'

class Node
  def initialize(data, color, piece = nil)
    @data = data
    @color = color
    @piece = piece
    @neighbors = []
    @visited = false
  end
  attr_accessor :data, :piece, :neighbors, :visited, :color

  def add_edge(neighbor)
    @neighbors << neighbor
  end
end
