# frozen_string_literal: true

require_relative '../lib/node'

RSpec.describe Node do
  
  describe '#convert_data' do
  
    context 'when data with [0, 0] is given' do
    subject(:node_data) { Node.new([0, 0], "\e[1;47m   \e[0m") }
      
      it 'returns a8' do
        expect(node_data.coords).to eq('a8')
      end
    end
  end

  describe '#piece_print' do
  subject(:node_print) { Node.new([0, 0], "\e[1;47m   \e[0m", "\e[1;34m♜") }

    context 'when a square and a piece are given' do

      it 'returns the square with the piece in one string' do
        sqr = "\e[1;47m   \e[0m"
        result = "\e[1;47m \e[1;34m♜ \e[0m"
        expect(node_print.piece_print(sqr.dup)).to eq(result)
      end
    end
  end

end