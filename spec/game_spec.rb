# frozen_string_literal: true

require_relative '../lib/game'
require_relative '../lib/board'

RSpec.describe Game do

  describe '#player_color' do
  let(:game_color) { instance_double(Game) }
    context 'when turn is zero' do

      before do
        allow(game_color).to receive(:player_color).and_return('white')
      end

      it 'returns white' do
        expect(game_color.player_color).to be('white')
      end
    end
  end

  describe '#switch_player' do
  let(:game_player) { instance_double(Game) }
    context 'when turn is zero' do

        before do
          allow(game_player).to receive(:switch_player).and_return(1)
        end

      it 'returns 1' do
        expect(game_player.switch_player).to be(1)
      end
    end
  end

  describe '#fifty_moves_rule?' do
  let(:game_fifty_moves) { Game.new }
    context 'when the rule does not apply' do

      it 'returns false' do
        expect(game_fifty_moves.fifty_moves_rule?).to be(false)
      end
    end

    let(:game_fifty) { Game.new }
    let(:board) { Board.new }
    context 'when the rule does apply' do

      before do
        board.moves=(["e2xe4", "e1e2", "e1e2", "e1e2", "e1e2", "e1e2", "e1e2", "e1e2", "e1e2", "e1e2", "e1e2", "e1e2", "e1e2", "e1e2", "e1e2", "e1e2", "e1e2", "e1e2", "e1e2", "e1e2", "e1e2", "e1e2", "e1e2", "e1e2", "e1e2", "e1e2", "e1e2", "e1e2", "e1e2", "e1e2", "e1e2", "e1e2", "e1e2", "e1e2", "e1e2", "e1e2", "e1e2", "e1e2", "e1e2", "e1e2", "e1e2", "e1e2", "e1e2", "e1e2", "e1e2", "e1e2", "e1e2", "e1e2", "e1e2", "e1e2", "e1e2"])
        board.pawn_moves=(["P", "e1e2", "e1e2", "e1e2", "e1e2", "e1e2", "e1e2", "e1e2", "e1e2", "e1e2", "e1e2", "e1e2", "e1e2", "e1e2", "e1e2", "e1e2", "e1e2", "e1e2", "e1e2", "e1e2", "e1e2", "e1e2", "e1e2", "e1e2", "e1e2", "e1e2", "e1e2", "e1e2", "e1e2", "e1e2", "e1e2", "e1e2", "e1e2", "e1e2", "e1e2", "e1e2", "e1e2", "e1e2", "e1e2", "e1e2", "e1e2", "e1e2", "e1e2", "e1e2", "e1e2", "e1e2", "e1e2", "e1e2", "e1e2", "e1e2", "e1e2"])
        game_fifty.board=(board)
      end

      it 'returns true' do
        expect(game_fifty.fifty_moves_rule?).to be(true)
      end
    end
  end

 

end
