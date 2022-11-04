# frozen_string_literal: true

require_relative '../lib/pieces'

RSpec.describe Pieces do
    
  describe '#add_piece' do
  let(:pieces) { instance_double(Pieces) }
  
    context 'when given a color and a piece' do
      
      before do
        
      end

      it 'increases the length of @white_pieces by 1' do
        expect(pieces.add_piece)
      end
    end
  end

end