# frozen_string_literal: true

require_relative '../lib/game'
require_relative '../lib/board'
require_relative '../lib/node'
require_relative '../lib/pieces/pawn'
require_relative '../lib/pieces/bishop'

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

  describe '#threefold_repetion?' do
    let(:game_threefold) { Game.new }
    context 'when the rule does not apply' do

      it 'returns false' do
        expect(game_threefold.threefold_repetion?).to be(false)
      end
    end

    context 'when the rule does apply' do

      before do
        game_threefold.positions=([1, 2, 3, 4, 5, 6, 1, 2, 3, 4, 5, 6])
      end

      it 'returns true' do
        expect(game_threefold.threefold_repetion?).to be(true)
      end
    end
  end

  describe '#insufficient_mating_material?' do
    context 'when the rule does not apply' do
      let(:game_material) { Game.new }
      let(:board_material) { Board.new } 
      before do
        node1 = Node.new([1, 0], "white", Pawn.new(0, 0))
        node2 = Node.new([0, 1], "black", Bishop.new(1, 1))

        board_material.graph.nodes = [node1, node2]

        game_material.board=(board_material)
      end

      it 'returns false' do
        expect(game_material.insufficient_mating_material?).to be(false)
      end
    end

    context 'when the rule does apply' do
      let(:game_material2) { Game.new }
      let(:board_material2) { Board.new } 
      before do
        node1 = Node.new([1, 0], "white", Bishop.new(0, 0))
        node2 = Node.new([0, 1], "black", Bishop.new(1, 1))
        node3 = Node.new([3, 0], "white", Bishop.new(0, 0))
        board_material2.graph.nodes = [node1, node2, node3]

        game_material2.board=(board_material2)
      end

      it 'returns true' do
        expect(game_material2.insufficient_mating_material?).to be(true)
      end
    end
  end
end
