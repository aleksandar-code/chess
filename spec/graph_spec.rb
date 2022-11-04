# frozen_string_literal: true

require_relative '../lib/graph'

RSpec.describe Graph do
  
  describe '#add_node' do
  subject(:graph_node) { Graph.new }
    context 'when a node is given as argument' do
      
      it 'increase the length of @nodes by 1' do
        expect { graph_node.add_node('Node') }.to change { graph_node.nodes.length }.by(1)
      end
    end
  end

end