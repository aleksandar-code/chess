# frozen_string_literal: true

require_relative '../lib/board'
require_relative '../lib/game'
require_relative '../lib/pieces/king'

RSpec.describe Board do
  
  describe '#move' do
    let(:game) { Game.new }
    let(:board) { Board.new }

    before do
      game.board=(board)
      game.board.add_board_and_moves_and_graph
    end

    context 'when input is valid' do
      it 'returns nil' do
        allow(board).to receive(:get_move).and_return("g1f3")
        expect(game.board.move(0)).to be_nil
      end
    end

    let(:game) { Game.new }
    let(:board) { Board.new }

    before do
      game.board=(board)
      game.board.add_board_and_moves_and_graph
      allow(board).to receive(:get_move).and_return("g2f3", "g1f3")
    end

    context 'when input is not valid' do
      it 'returns an error message once' do
        expect(board).to receive(:puts).with("please enter a valid input").once
        board.move(0)
      end
    end
  end

  describe '#check_status' do

    let(:board) { Board.new }
    let(:king) { King.new(0, 0) }
    context 'when it is a legal move' do
      before do
      end
      it 'returns true' do
        start = board.get_square("a2")
        dest = board.get_square("a3")
        allow(board).to receive(:check?).and_return(false)
        
        expect(board.check_status(true, start, dest, "a2a3", 0 )).to be(true)
      end
    end

    let(:board) { Board.new }
    let(:king) { King.new(0, 0) }
    context 'when the king is in check' do
      before do
      end
      it 'returns false' do
        start = board.get_square("a2")
        dest = board.get_square("a3")
        allow(board).to receive(:check?).and_return("check")
        allow(board).to receive(:puts).and_return(nil)
        expect(board.check_status(true, start, dest, "a2a3", 0)).to be(false)
      end
    end
  end
  
end