# frozen_string_literal: true

require_relative '../lib/node'

RSpec.describe Node do
  
  describe '#convert_data' do
  
    context 'when data with [0, 0] is given' do
    subject(:node_data) { Node.new([0, 0], "e") }
      
      it 'returns a8' do
        expect(node_data.coords).to eq('a8')
      end
    end
  end

  describe '#piece_print' do
  let(:node_data) { instance_double(Node) }

    context 'when data with [0, 0] is given' do
      
      before do
        allow(node_data).to receive(:convert_data).with([0, 0]).and_return('a8')
      end

      it 'returns a8' do
        expect(node_data.convert_data([0, 0])).to eq('a8')
      end
    end
  end

end