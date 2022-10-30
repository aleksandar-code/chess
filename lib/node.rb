# frozen_string_literal: true

class Node
  def initialize(data)
    @data = data
    @neighbors = []
    @visited = false
  end
  attr_accessor :data, :neighbors, :visited
  
  def add_edge(neighbor)
    @neighbors << neighbor
  end
end
