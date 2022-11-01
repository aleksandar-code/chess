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
    @print_with_piece = nil
  end
  attr_accessor :piece, :neighbors, :visited, :print_with_piece
  attr_reader :square, :coords

  def add_edge(neighbor)
    @neighbors << neighbor
  end

  def piece_print(s)
    s[8] = @piece unless @piece.nil? # if there is a piece
    @print_with_piece = s unless @piece.nil?
  end

  def convert_data(data)
    arr_i = %w[8 7 6 5 4 3 2 1]
    arr_j = %w[a b c d e f g h]

    i = data[0]

    j = data[1]

    data[1] = arr_i[i]
    data[0] = arr_j[j]

    data = data[0] + data[1]
  end
end
