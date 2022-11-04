# frozen_string_literal: true

require_relative '../lib/game'

RSpec.describe Game do

  describe '#player_color' do
  subject(:game_color) { Game.new }
    context 'when turn is zero' do
  
      it 'returns white' do
        expect(game_color.player_color).to eq('white')
      end
    end
  end

  describe '#switch_player' do
    
    context 'when turn is zero' do

      it 'returns 1' do
        
      end
    end
  end

end
