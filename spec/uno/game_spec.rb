# frozen_string_literal: true

require 'uno/game'
require 'uno/player'

RSpec.describe UNO::Game do
  describe 'when operating with the deck' do
    let(:deck) { %w[uno dos tres] }
    let(:game) { described_class.new(deck) }

    it 'flips top card of the pool' do
      game.flip_top_card
      expect(game.pool.first).to eq('tres')
    end

    it 'knows the top card' do
      expect(game.top_card).to eq('uno')
    end

    it 'sorts the pool to reset the game' do
      game.pool.shuffle!
      game.reset
      expect(game.pool).to eq(deck)
    end
  end

  describe 'when dealing cards' do
    let(:game) { described_class.new }
    let(:jane) { UNO::Player.new('Jane') }
    let(:max_cards) { UNO::Constants::MAX_CARDS }

    before { game.deal_cards([jane]) }

    it 'delivers the maximum cards to each player' do
      expect(jane.cards.size).to eq(max_cards)
    end

    it 'shuffles the cards before dealing' do
      deck = UNO::Deck.build_deck
      expect(jane.cards).not_to eq(deck.last(max_cards))
    end
  end

  describe 'when playing' do
    let(:jane) { UNO::Player.new('Jane') }
    let(:joe) { UNO::Player.new('Joe') }

    it 'plays normally' do
      game = described_class.new
      jane.cards = %w[3-green 4-red]
      joe.cards = %w[5-blue 4-yellow]
      expected = [
        { name: 'Jane', card: '4-red' },
        { name: 'Joe',  card: '4-yellow' }
      ]
      expect(game.play([jane, joe], '4-blue')).to eq(expected)
    end

    it 'makes the player draw a card and play it' do
      game = described_class.new(%w[3-blue])
      jane.cards = %w[3-green 4-red]
      expected = [{ name: 'Jane', card: '3-blue' }]
      expect(game.play([jane], '2-blue')).to eq(expected)
    end

    it 'makes the player draw a card and skip turn if it is not playable' do
      game = described_class.new(%w[3-blue])
      jane.cards = %w[3-green 4-red]
      expected = [{ name: 'Jane', card: nil }]
      expect(game.play([jane], '1-yellow')).to eq(expected)
    end

    it 'skips a player if they got rid of all cards' do
      game = described_class.new
      jane.cards = []
      joe.cards = %w[3-green]
      expected = [{ name: 'Joe', card: '3-green' }]
      expect(game.play([jane, joe], '3-yellow')).to eq(expected)
    end

    context 'with a skip top card' do
      let(:game) { described_class.new }

      it 'makes the player skip turn' do
        jane.cards = %w[3-green skip-red]
        joe.cards = %w[5-blue 4-red]
        expected = [
          { name: 'Jane', card: 'skip-red' }, { name: 'Joe', card: nil }
        ]
        expect(game.play([jane, joe], '4-red')).to eq(expected)
      end

      it 'does not make the next player skip turn' do
        jane.cards = %w[3-green 4-red]
        joe.cards = %w[1-blue 2-red]
        expected = [{ name: 'Jane', card: nil }, { name: 'Joe', card: '2-red' }]
        expect(game.play([jane, joe], 'skip-red')).to eq(expected)
      end

      it 'allows the after-next player to skip turn' do
        jane.cards = %w[3-green 4-red]
        joe.cards = %w[1-blue skip-green]

        mia = UNO::Player.new('Mia')
        mia.cards = %w[2-blue 3-green]
        expected = [
          { name: 'Jane', card: nil },
          { name: 'Joe', card: 'skip-green' },
          { name: 'Mia', card: nil }
        ]
        expect(game.play([jane, joe, mia], 'skip-red')).to eq(expected)
      end
    end

    context 'with a draw2 top card' do
      let(:game) { described_class.new(%w[3-blue 2-red]) }

      it 'makes the player draw 2 cards' do
        jane.cards = %w[3-green 4-red]
        game.play([jane], 'draw2-red')
        expect(jane.cards).to eq(%w[3-green 4-red 3-blue 2-red])
      end

      it 'makes the player skip turn' do
        jane.cards = %w[3-green 4-red]
        expected = [{ name: 'Jane', card: nil }]
        expect(game.play([jane], 'draw2-red')).to eq(expected)
      end

      it 'removes drawn cards from the pool' do
        jane.cards = %w[3-green 4-red]
        game.play([jane], 'draw2-red')
        expect(game.pool).to be_empty
      end

      it 'does not make the next player skip turn' do
        jane.cards = %w[3-green 4-red]
        joe.cards = %w[1-green 2-red]
        expected = [{ name: 'Jane', card: nil }, { name: 'Joe', card: '2-red' }]
        expect(game.play([jane, joe], 'draw2-red')).to eq(expected)
      end

      it 'allows the after-next player to skip turn' do
        game = described_class.new(%w[3-blue 2-red 3-blue 2-red])
        jane.cards = %w[3-green 4-red]
        joe.cards = %w[1-blue draw2-green]

        mia = UNO::Player.new('Mia')
        mia.cards = %w[2-blue 3-green]
        expected = [
          { name: 'Jane', card: nil },
          { name: 'Joe', card: 'draw2-green' },
          { name: 'Mia', card: nil }
        ]
        expect(game.play([jane, joe, mia], 'draw2-red')).to eq(expected)
      end
    end

    context 'with a draw4 top card' do
      let(:game) { described_class.new(%w[3-blue 2-red 1-yellow 5-blue]) }

      it 'makes the player draw 4 cards' do
        jane.cards = %w[3-green 4-red]
        game.play([jane], 'draw4-red')
        expect(jane.cards).to eq(%w[3-green 4-red 3-blue 2-red 1-yellow 5-blue])
      end

      it 'makes the player skip turn' do
        jane.cards = %w[3-green 4-red]
        expected = [{ name: 'Jane', card: nil }]
        expect(game.play([jane], 'draw4-red')).to eq(expected)
      end

      it 'removes drawn cards from the pool' do
        jane.cards = %w[3-green 4-red]
        game.play([jane], 'draw4-red')
        expect(game.pool).to be_empty
      end

      it 'does not make the next player skip turn' do
        jane.cards = %w[3-green 4-red]
        joe.cards = %w[1-green 2-red]
        expected = [{ name: 'Jane', card: nil }, { name: 'Joe', card: '2-red' }]
        expect(game.play([jane, joe], 'draw4-red')).to eq(expected)
      end

      it 'allows the after-next player to skip turn' do
        game = described_class.new(
          %w[3-blue 2-red 3-blue 2-red 3-blue 2-red 3-blue 2-red]
        )
        jane.cards = %w[3-green 4-red]
        joe.cards = %w[1-blue draw4-green]

        mia = UNO::Player.new('Mia')
        mia.cards = %w[2-blue 3-green]
        expected = [
          { name: 'Jane', card: nil },
          { name: 'Joe', card: 'draw4-green' },
          { name: 'Mia', card: nil }
        ]
        expect(game.play([jane, joe, mia], 'draw4-red')).to eq(expected)
      end
    end

    context 'with a reverse top card' do
      xit 'can play in reverse' do
        game = described_class.new

        jane.cards = %w[0-yellow 1-yellow]
        joe.cards = %w[5-blue reverse-yellow]
        mia = UNO::Player.new('Mia')
        mia.cards = %w[1-blue 5-green]

        expected = [
          { name: 'Jane', card: '0-yellow' },
          { name: 'Joe', card: 'reverse-yellow' },
          { name: 'Jane', card: '1-yellow' },
          { name: 'Mia', card: '1-blue' },
          { name: 'Joe', card: '5-blue' }
        ]
        expect(game.play([jane, joe, mia], '0-green')).to eq(expected)
      end
    end
  end

  describe 'when playing with a human' do
    let(:deck) { %w[uno dos tres cuatro] }
    let(:game) { described_class.new(deck) }
    let(:human) { UNO::Player.new('Human', %w[0-green 1-red]) }

    context 'with card chosen' do
      def play
        game.human_play(human, '1-red', '1-red')
      end

      it 'plays the card' do
        play
        expect(human.cards).to eq(['0-green'])
      end

      it 'adds the card at the top of the pool' do
        play
        expect(game.pool).to eq(%w[1-red uno dos tres cuatro])
      end

      it 'returns a hand' do
        result = play
        expect(result).to eq(name: 'Human', card: '1-red')
      end

      it 'returns nothing if player finished' do
        play
        result = game.human_play(human, '0-green', '0-green')
        expect(result).to be_nil
      end
    end

    context 'with skip card' do
      def play
        game.human_play(human, nil, 'skip-red')
      end

      it 'does not change player cards' do
        play
        expect(human.cards).to eq(%w[0-green 1-red])
      end

      it 'does not change the pool' do
        play
        expect(game.pool).to eq(%w[uno dos tres cuatro])
      end

      it 'returns a hand' do
        result = play
        expect(result).to eq(name: 'Human', card: nil)
      end
    end

    context 'with draw card' do
      it 'increases player cards with cards from the back of the pool' do
        game.human_play(human, nil, 'draw2-red')
        expect(human.cards).to eq(%w[0-green 1-red tres cuatro])
      end

      it 'removes cards from the back the pool' do
        game.human_play(human, nil, 'draw4-red')
        expect(game.pool).to be_empty
      end

      it 'returns a hand' do
        result = game.human_play(human, nil, 'draw4-red')
        expect(result).to eq(name: 'Human', card: nil)
      end
    end
  end
end
