# frozen_string_literal: true

class Node
  def initialize(data, piece)
    @data = data
    @piece = piece
    @next_node = next_node
  end
  attr_accessor :data, :neighbors, :visited

  def next_node(next_node=nil) 
    @next_node = next_node
  end
end
