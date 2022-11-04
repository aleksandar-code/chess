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

  # add method remove piece and then remove print with piece etc.

  def piece_print(sqr)
    sqr[8] = @piece unless @piece.nil? # if there is a piece
    @print_with_piece = sqr unless @piece.nil?
  end

  def convert_data(data)
    arr_i = %w[8 7 6 5 4 3 2 1]
    arr_j = %w[a b c d e f g h]

    arr_j[data[1]] + arr_i[data[0]]
  end
end
