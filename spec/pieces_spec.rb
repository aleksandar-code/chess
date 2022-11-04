# frozen_string_literal: true

require_relative '../lib/pieces'

RSpec.describe Pieces do
    
  describe '#add_piece' do
  subject(:pieces) { Pieces.new }

    context 'when given a color and a piece' do

      it 'increases the length of @white_pieces by 1' do
        expect { pieces.add_piece(0, "piece") }.to change { pieces.white_pieces.length }.by(1)
      end
    end
  end

end