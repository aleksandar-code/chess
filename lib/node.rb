# frozen_string_literal: true

require_relative './board'
require_relative './graph'

class Node
  def initialize(coords, square, piece = nil)
    @coords = convert_data(coords)
    @square = square
    @piece = piece
    @neighbors = []
    @visited = false
  end
  attr_accessor :coords, :piece, :neighbors, :visited, :square

  def add_edge(neighbor)
    @neighbors << neighbor
  end

  def convert_data(data)
    arr_i = ['8', '7', '6', '5', '4', '3', '2', '1']
    arr_j = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h']


    i = data[0]

    j = data[1]

    data[1] = arr_i[i]
    data[0] = arr_j[j]

    data = data[0] + data[1]

  end
end
