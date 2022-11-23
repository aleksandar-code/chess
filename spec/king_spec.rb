# frozen_string_literal: true

require_relative '../lib/pieces/king'
require_relative '../lib/game'
require_relative '../lib/board'


RSpec.describe King do
  describe '#stalemate' do
    context 'when a position is not a stalemate' do
      let(:game) { Game.new }
      let(:king) { King.new(0, 0) }
      let(:board) { Board.new }

      before do
        allow(king).to receive(:get_all_moves).and_return([6, 0], [5, 0])
        allow(king).to receive(:test_moves).and_return([6, 0], [5, 0])
      end

      it 'returns false' do
        expect(king.stalemate(0)).to be(false)
      end
    end

    context 'when a position is a stalemate' do
      let(:game) { Game.new }
      let(:king) { King.new(0, 0) }
      let(:board) { Board.new }
      before do
        allow(king).to receive(:get_all_moves).and_return([6, 0], [5, 0])
        allow(king).to receive(:test_moves).and_return([])
      end

      it 'returns true' do
        expect(king.stalemate(0)).to be(true)
      end
    end
  end

  describe '#check_mate' do
    context 'when a position is not a check_mate' do
      let(:game) { Game.new }
      let(:king) { King.new(0, 0) }
      let(:board) { Board.new }

      before do
        allow(king).to receive(:get_all_moves).and_return([6, 0], [5, 0])
        allow(king).to receive(:test_moves).and_return([6, 0], [5, 0])
      end

      it 'returns false' do
        expect(king.check_mate(0)).to be(false)
      end
    end

    context 'when a position is a check_mate' do
      let(:game) { Game.new }
      let(:king) { King.new(0, 0) }
      let(:board) { Board.new }
      before do
        allow(king).to receive(:get_all_moves).and_return([6, 0], [5, 0])
        allow(king).to receive(:test_moves).and_return(["check", "check"])
      end

      it 'returns true' do
        expect(king.check_mate(0)).to be(true)
      end
    end
  end

  describe '#test_moves' do
  
  
    context 'when there is no checks at all' do
      let(:king) { King.new(0, 0) }
      let(:board) { Board.new }
    
      before do
        king.board=(board.board)
        allow(king).to receive(:check?).and_return(false)
      end
        
      it 'returns the array of moves' do
        start_dest = [[[6, 0], [4, 0]], [[6, 4], [4, 4]]]
        expect(king.test_moves(start_dest, 0)).to eql(start_dest)
      end
    end
  end
end