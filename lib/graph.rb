# frozen_string_literal: true

require_relative './node'
require_relative './board'

class Graph
  def initialize
    @nodes = []
    @destination_square = nil
  end
  attr_accessor :nodes, :destination_square

  def add_node(node)
    @nodes << node
  end

  def get_node(coords)
    @nodes.each do |n|
      return n if coords == n.coords
    end
    nil
  end

  def get_idx(coords)
    @nodes.each_with_index do |n, idx|
      return idx if coords == n.coords
    end
    nil
  end

  def get_edge(coords)
    start = @nodes[get_idx(coords)]
    start.neighbors[0].coords
  end

  def check_all_moves(our_id)
    all_moves = []
    @nodes.each do |node|
      if !(node.piece.nil?)
        if node.piece.id == our_id
          coords = node.piece.find_piece(node)
          curr_moves = node.piece.possible_moves(coords, 0)
          for move in curr_moves
            all_moves << move
          end
        end
      end
    end
    all_moves

    # if there's any valid then not checkmate // remove all moves that return check
  end

  # make method to get all moves of our id pieces if in check to check if checkmate if not return false
end
