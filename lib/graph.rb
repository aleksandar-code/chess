# frozen_string_literal: true

class Graph
  def initialize
    @nodes = []
    @destination_square = nil
  end
  attr_accessor :nodes, :destination_square
  
  def add_node(value)
    @nodes << Node.new(value)
  end
  
  def get_node(data)
    @nodes.each do |n|
      return n if data == n.data
    end
  end
  
  def get_idx(data)
    @nodes.each_with_index do |n, idx|
      return idx if data == n.data
    end
  end
  
  def get_edge(data)
    start = @nodes[get_idx(data)]
    start.neighbors[0].data
  end
end
